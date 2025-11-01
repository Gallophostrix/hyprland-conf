{pkgs, ...}: let
  # Store paths resolved at build time
  themesDir = ./.; # whole theme-switcher folder
  rofiMain = ./theme-switcher.rasi; # main rofi stylesheet
in {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "theme-switcher";
      runtimeInputs = with pkgs; [
        rofi
        coreutils
        findutils
        gnused
        swww
        glib
        libnotify
      ];
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        # --- All paths are absolute (from Nix store) ---
        THEMES_DIR='${themesDir}'
        ROFI_THEME='${rofiMain}'

        # List subdirectories (themes)
        mapfile -t themes < <(find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | sort)
        if [[ "''${#themes[@]}" -eq 0 ]]; then
          echo "No themes in $THEMES_DIR" >&2
          exit 1
        fi

        # Choose a theme
        if [[ -f "$THEME_PATH/''${chosen_theme}.rasi" ]]; then
                  THEME_RASI="$THEME_PATH/''${chosen_theme}.rasi"
        else
                  THEME_RASI="$ROFI_BASE"
        fi

                # 4) Export for sub-scripts (wallpaper.sh, gtk-icons.sh, etc.)
                export CHOSEN_THEME="''${chosen_theme}"
                export THEME_PATH
                export THEME_RASI

                # 5) Execute known steps, if present and executable
                for script in theme.sh wallpaper.sh hypr-waybar-rofi.sh gtk-icons.sh; do
                  sp="$THEME_PATH/$script"
                  if [[ -x "$sp" ]]; then
                    echo "Executing: $sp"
                    bash "$sp"
                  fi
                done

        notify-send "Theme Switcher" "Applied theme: ''${chosen_theme}" || true
      '';
    })
  ];
}
