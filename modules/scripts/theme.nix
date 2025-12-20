{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellApplication {
  name = "theme-switcher";

  # All dependencies used at runtime
  runtimeInputs = with pkgs; [
    rofi
    fd
    coreutils
    gnused
    gnugrep
    findutils
    jq
    swww
    procps # pidof/pkill
    # libsForQt5.kvantum
    # qt6Packages.kvantum
    glib # gsettings
  ];

  text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    THEMES_DIR="${themesRoot}"
    THEME_LINK="$HOME/.config/theme-current"

    # --- Rofi setup ---
    if pidof rofi >/dev/null 2>&1; then
      pkill rofi || true
      exit 0
    fi
    rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
    r_override="entry{placeholder:'Search Themes...';}"

    rofi_cmd() {
      rofi -dmenu -i -markup-rows -theme-str "$r_override" -theme "$rofi_theme"
    }

    # --- Sanity checks ---
    if [[ ! -d "$THEMES_DIR" ]]; then
      echo "Themes directory not found: $THEMES_DIR" >&2
      exit 1
    fi

    # --- Build menu (name + optional colored text from manifest.json) ---
    # Expected manifest.json keys (all optional):
    # {
    #   "name": "Catppuccin Mocha (Mauve)",
    #   "accentColor": "#c6a0f6",
    #   "gtkThemeName": "catppuccin-mocha-mauve-compact",
    #   "kvantumThemeName": "catppuccin-mocha-mauve",
    #   "cursorName": "Bibata-Modern-Classic",
    #   "defaultWallpaper": "wallpapers/foo.jpg"
    # }
    declare -A MAP=()

    menu_lines=""
    while IFS= read -r d; do
      base="$(basename "$d")"
      manifest="$d/manifest.json"
      display="$base"
      color=""

      if [[ -f "$manifest" ]]; then
        # Read human name or fallback to dir name
        display="$(jq -r '.name // empty' "$manifest" 2>/dev/null || true)"
        [[ -z "$display" ]] && display="$base"
        # Accent color (hex) for colored text
        color="$(jq -r '.accentColor // empty' "$manifest" 2>/dev/null || true)"
      fi

      # Assign the directory path to the key in the MAP array
      MAP["$display"]="$d"

      if [[ -n "$color" ]]; then
        menu_lines+=$'<span foreground="'"$color"'">'$display$'</span>\n'
      else
        menu_lines+="$display"$'\n'
      fi
    done < <(${lib.getExe pkgs.fd} -td -d1 . "$THEMES_DIR" | sort)

    # Empty?
    if [[ -z "$menu_lines" ]]; then
      echo "No themes found in $THEMES_DIR" >&2
      exit 1
    fi

    # --- Ask user ---
    CHOICE="$(printf "%b" "$menu_lines" | rofi_cmd || true)"
    [[ -z "$CHOICE" ]] && exit 0

    # Strip markup (keep plain text)
    CHOICE_PLAIN="$(sed -E 's/<[^>]+>//g' <<<"$CHOICE")"

    # Resolve selected directory
    THEME_DIR="''${MAP[$CHOICE_PLAIN]}"
    [[ -z "$THEME_DIR" ]] && { echo "Theme not found"; exit 1; }

    # --- Switch pivot symlink ---
    mkdir -p "$(dirname "$THEME_LINK")"
    ln -sfn "$THEME_DIR" "$THEME_LINK"

    # --- Read manifest (if any) ---
    manifest="$THEME_DIR/manifest.json"
    gtk_name=""
    kv_name=""
    cursor_name=""
    default_wallpaper=""

    if [[ -f "$manifest" ]]; then
      gtk_name="$(jq -r '.gtkThemeName // empty' "$manifest" 2>/dev/null || true)"
      kv_name="$(jq -r '.kvantumThemeName // empty' "$manifest" 2>/dev/null || true)"
      cursor_name="$(jq -r '.cursorName // empty' "$manifest" 2>/dev/null || true)"
      default_wallpaper="$(jq -r '.defaultWallpaper // empty' "$manifest" 2>/dev/null || true)"
    fi

    # --- Apply GTK theme (imperative; rebuild remettra la valeur déclarative) ---
    if [[ -n "$gtk_name" ]]; then
      gsettings set org.gnome.desktop.interface gtk-theme "$gtk_name" 2>/dev/null || true
    fi

    # --- Apply Kvantum (Qt) ---
    if command -v kvantummanager >/dev/null 2>&1 && [[ -n "$kv_name" ]]; then
      kvantummanager --set "$kv_name" 2>/dev/null || true
    else
      # Fallback: write kvconfig if exists
      kv_cfg="$HOME/.config/Kvantum/kvantum.kvconfig"
      if [[ -n "$kv_name" && -f "$kv_cfg" ]]; then
        sed -i "s|^theme=.*|theme=\"$kv_name\"|" "$kv_cfg" || true
      fi
    fi

    # --- Apply cursor ---
    if [[ -n "$cursor_name" ]]; then
      if command -v hyprctl >/dev/null 2>&1; then
        hyprctl setcursor "$cursor_name" 24 2>/dev/null || true
      fi
      gsettings set org.gnome.desktop.interface cursor-theme "$cursor_name" 2>/dev/null || true
    fi

    # --- Apply wallpaper ---
    # Choose manifest default if present, else first file under wallpapers/
    wp_path=""
    if [[ -n "$default_wallpaper" && -f "$THEME_DIR/$default_wallpaper" ]]; then
      wp_path="$THEME_DIR/$default_wallpaper"
    else
      first="$(find "$THEME_DIR/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jxl" -o -iname "*.gif" \) -print -quit 2>/dev/null || true)"
      [[ -n "$first" ]] && wp_path="$first"
    fi

    if [[ -n "$wp_path" ]]; then
      # ensure daemon is running
      if ! pgrep -x swww-daemon >/dev/null 2>&1; then
        swww-daemon --format xrgb &>/dev/null &
        sleep 0.2
      fi
      swww img "$wp_path" --transition-type wipe --transition-duration 1 --transition-fps 60 --transition-step 90 2>/dev/null || true
    fi

    # --- Refresh bars/compositor (best-effort) ---
    pkill -USR2 waybar 2>/dev/null || true
    if command -v hyprctl >/dev/null 2>&1; then
      hyprctl reload 2>/dev/null || true
    fi

    exit 0
  '';
}
