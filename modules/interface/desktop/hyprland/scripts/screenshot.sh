#!/usr/bin/env bash
set -Eeuo pipefail

: "${HYPRSHOT_DIR:?HYPRSHOT_DIR must be set by Hyprland env}"
mkdir -p -- "$HYPRSHOT_DIR"

# --- Deps check ---------------------------------------------------------------
need() { command -v "$1" >/dev/null 2>&1 || { echo "$1 not found"; exit 1; }; }
need hyprshot
command -v wl-copy >/dev/null || true
command -v notify-send >/dev/null || true

# --- Notify helper ------------------------------------------------------------
notify() { command -v notify-send >/dev/null && notify-send -e -t 1800 -u low "$@"; }

# --- Feature detection: clipboard-on-save -------------------------------------
HAS_CLIPBOARD_ON_SAVE=false
hyprshot --help 2>&1 | grep -qi -- "--clipboard" && HAS_CLIPBOARD_ON_SAVE=true

# --- Usage --------------------------------------------------------------------
usage() {
  cat <<EOF
Usage: $(basename "$0") <mode> [flags]

Modes:
  s    : window (Esc -> region; Esc again -> cancel)
  m    : select output (click monitor)
  p    : all outputs

Flags:
  c    : clipboard-only (no file)

Notes:
- Default is copy+save; with 'c' = clipboard-only.
- Fallback (s) uses a different filename to avoid overwrite.
EOF
  exit 1
}

# --- Args ---------------------------------------------------------------------
MODE="${1:-}"; [ -n "$MODE" ] || usage; shift || true

FLAGS_CAT=""
for a in "$@"; do FLAGS_CAT="${FLAGS_CAT}${a}"; done
COPY_ONLY=0
[ -n "$FLAGS_CAT" ] && echo "$FLAGS_CAT" | grep -q "c" && COPY_ONLY=1

# --- Filename helpers ---------------------------------------------------------
timestamp() { date +'%Y%m%d_%H%M%S'; }

ensure_unique_base() {
  local base n out
  base="${1:?ensure_unique_base: missing base}"
  n=1; out="$base"
  while [ -e "$HYPRSHOT_DIR/$out" ] || [ -e "$HYPRSHOT_DIR/$out.png" ]; do
    out="${base}_$((n++))"
  done
  printf '%s' "$out"
}

# Wait up to ~2s for file to appear (handles async write)
wait_for_output() {
  # $1=base (without .png). Sets global VAR OUT_PATH on success.
  local base="$1" i=0
  local raw="$HYPRSHOT_DIR/$base"
  local png="$HYPRSHOT_DIR/$base.png"
  for i in $(seq 1 40); do  # ~2s @ 50ms
    if [ -e "$png" ]; then OUT_PATH="$png"; return 0; fi
    if [ -e "$raw" ]; then OUT_PATH="$raw"; return 0; fi
    sleep 0.05
  done
  return 1
}

finalize_png() {
  # Ensure .png extension
  if [ -n "${OUT_PATH:-}" ] && [ -e "$OUT_PATH" ]; then
    case "$OUT_PATH" in
      *.png) : ;;
      *) mv -- "$OUT_PATH" "$OUT_PATH.png"; OUT_PATH="$OUT_PATH.png" ;;
    esac
  fi
}

# --- Hyprshot runners ---------------------------------------------------------
run_clipboard_only() {
  # $1=mode
  hyprshot -m "$1" --clipboard-only
}

run_copy_and_save() {
  # $1=mode, $2=basename (no path)
  if [ "$HAS_CLIPBOARD_ON_SAVE" = true ]; then
    # hyprshot can save AND copy
    hyprshot -m "$1" --clipboard -o "$HYPRSHOT_DIR" -f "$2"
  else
    # Save first, then copy with wl-copy (if available)
    hyprshot -m "$1" -o "$HYPRSHOT_DIR" -f "$2" || return $?
    OUT_PATH=""
    wait_for_output "$2" || true
    finalize_png
    if command -v wl-copy >/dev/null 2>&1 && [ -n "${OUT_PATH:-}" ] && [ -e "$OUT_PATH" ]; then
      wl-copy < "$OUT_PATH" || true
    fi
  fi
}

# Try capture -> success if exit 0 OR file appears during polling
try_capture_save() {
  # $1=mode, $2=basename
  local mode="$1" base="$2"
  OUT_PATH=""
  if run_copy_and_save "$mode" "$base"; then
    wait_for_output "$base" || true
    finalize_png
    [ -n "${OUT_PATH:-}" ] && [ -e "$OUT_PATH" ]
    return 0
  else
    if wait_for_output "$base"; then
      finalize_png
      return 0
    fi
    return 1
  fi
}

shoot_window_with_fallback() {
  if [ "$COPY_ONLY" -eq 1 ]; then
    if run_clipboard_only window; then
      notify "Screenshot" "Copied (window)"; return 0
    fi
    if run_clipboard_only region; then
      notify "Screenshot" "Copied (region)"; return 0
    fi
    notify "Screenshot" "Cancelled"; return 2
  else
    local base_main base_fb
    base_main="$(ensure_unique_base "screenshot_$(timestamp)")"
    if try_capture_save window "$base_main"; then
      notify "Screenshot" "Saved (window)\n${OUT_PATH}"; return 0
    fi
    base_fb="$(ensure_unique_base "${base_main}_region")"
    if try_capture_save region "$base_fb"; then
      notify "Screenshot" "Saved (region)\n${OUT_PATH}"; return 0
    fi
    notify "Screenshot" "No file saved (cancelled)"; return 2
  fi
}

shoot_simple() {
  # $1=label, $2=mode
  local label="$1" mode="$2"
  if [ "$COPY_ONLY" -eq 1 ]; then
    if run_clipboard_only "$mode"; then
      notify "Screenshot" "Copied (${label})"; return 0
    fi
    notify "Screenshot" "Cancelled (${label})"; return 2
  else
    local base
    base="$(ensure_unique_base "screenshot_$(timestamp)")"
    if try_capture_save "$mode" "$base"; then
      notify "Screenshot" "Saved (${label})\n${OUT_PATH}"; return 0
    fi
    notify "Screenshot" "No file saved (${label} cancelled)"; return 2
  fi
}

case "$MODE" in
  s) shoot_window_with_fallback ;;
  m) shoot_simple "output" "output" ;;
  p) shoot_simple "all screens" "screen" ;;
  *) usage ;;
esac

exit 0
