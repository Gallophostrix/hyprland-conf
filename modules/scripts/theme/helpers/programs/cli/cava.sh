#!/usr/bin/env bash
set -euo pipefail

CAVA_CFG="$XDG_CONFIG_HOME/cava/config"
CAVA_COLORS="$THEME_DIR/cava/colors.conf"

[ -f "$CAVA_CFG" ]    || exit 0
[ -f "$CAVA_COLORS" ] || exit 0

# Replace the [color] section with that of the theme
awk -v frag="$CAVA_COLORS" '
  BEGIN{ incolor=0 }
  /^\[color\]$/ { print; incolor=1; next }
  /^\[/ {
    if (incolor) {
      while ((getline line < frag) > 0) print line
      close(frag)
      incolor=0
    }
    print; next
  }
  { if (!incolor) print }
  END {
    if (incolor) {
      while ((getline line < frag) > 0) print line
      close(frag)
    }
  }
' "$CAVA_CFG" > "$CAVA_CFG.tmp" && mv "$CAVA_CFG.tmp" "$CAVA_CFG"
