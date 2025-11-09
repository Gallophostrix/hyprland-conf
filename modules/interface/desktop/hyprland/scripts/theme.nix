{
  pkgs,
  defaultTheme,
  ...
}:
pkgs.writeShellScriptBin "theme" ''
  #!/usr/bin/env bash
  set -euo pipefail

  THEMES_DIR="$HOME/nixcfg/interface/themes"
  THEME_LINK="$HOME/.config/theme-current"
  DEFAULT_THEME="${defaultTheme}"

  # --- Restore previous theme if link exists ---
  if [[ -L "$THEME_LINK" && -d "$(readlink "$THEME_LINK")" ]]; then
    echo "Theme already active: $(basename "$(readlink "$THEME_LINK")")"
    exit 0
  fi

  # --- Apply default theme if no link or invalid ---
  if [[ -d "$THEMES_DIR/$DEFAULT_THEME" ]]; then
    echo "Applying default theme: $DEFAULT_THEME"
    ln -sfn "$THEMES_DIR/$DEFAULT_THEME" "$THEME_LINK"
  else
    echo "Default theme not found: $THEMES_DIR/$DEFAULT_THEME" >&2
    exit 1
  fi

  # --- Optionally trigger theme effects (reload Waybar, etc.) ---
  pkill -USR2 waybar 2>/dev/null || true
  if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload 2>/dev/null || true
  fi
''
