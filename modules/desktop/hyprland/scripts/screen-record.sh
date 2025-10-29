#!/usr/bin/env bash
set -Eeuo pipefail

XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"
DIR="${XDG_VIDEOS_DIR}/screen-record"
mkdir -p "$DIR"

need() { command -v "$1" >/dev/null 2>&1 || { echo "$1 not found"; exit 1; }; }
need wf-recorder
need slurp
command -v notify-send >/dev/null || true

ts="$(date +'%Y%m%d_%H%M%S')"
OUT="$DIR/record_${ts}.mp4"

# Toggle stop
if pidof wf-recorder >/dev/null; then
  pkill wf-recorder
  notify-send -e -t 2000 -u low "Recording Finished" "Saved to $OUT" || true
  exit 0
fi

case "${1:-}" in
  a) region="$(slurp)"   ;;
  m) region="$(slurp -o)";;
  *) echo "Usage: $(basename "$0") a|m (area|monitor)"; exit 1 ;;
esac

notify-send -e -t 1500 -u low "Recording Started" || true
wf-recorder --audio -g "$region" -f "$OUT"
