{
  host,
  pkgs,
  ...
}:
pkgs.writeShellScriptBin "rebuild" ''
  #!/usr/bin/env bash
  set -euo pipefail

  # --- Colors & helpers ---
  RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m\033[K'
  info()  { printf "\n%b%s%b\n" "$GREEN" "$1" "$NC"; }
  warn()  { printf "%b%s%b\n" "$YELLOW" "$1" "$NC"; }
  error() { printf "%bError: %s%b\n" "$RED" "$1" "$NC" >&2; }


  # --- No root ---
  if [ "$(id -u)" -eq 0 ]; then
    error "Do not run this script as root."
    exit 1
  fi

  # --- Pick flake directory ---
  if [ -f "$HOME/nixcfg/flake.nix" ]; then
    flake="$HOME/nixcfg"
  elif [ -f "$HOME/NixOS/flake.nix" ]; then
    flake="$HOME/NixOS"
  elif [ -f "/etc/nixos/flake.nix" ]; then
    flake="/etc/nixos"
  else
    error "flake.nix not found (looked in ~/nixcfg, ~/NixOS, /etc/nixos)."
    exit 1
  fi

  info "Flake: $flake"
  info "Host: ${host}"

  # --- Resolve invoking user (works with/without sudo) ---
  if printenv SUDO_USER >/dev/null 2>&1; then
    currentUser="$(printenv SUDO_USER)"
  else
    currentUser="$USER"
  fi

  # --- Sync username in variables.nix, if present ---
  vars_file="$flake/hosts/${host}/variables.nix"
  if [ -f "$vars_file" ]; then
    sudo sed -i -E "s/username = \".*\"/username = \"$currentUser\"/" "$vars_file"
  else
    warn "No variables.nix for host ${host}; skipping username sync."
  fi

  # --- Switch ---
  sudo nixos-rebuild switch --flake "$flake#${host}"

  # --- Pause ---
  printf '%b%s%b' "$GREEN" "Press any key to continue" "$NC"
  # shellcheck disable=SC2162
  read -rsn1 _ || true
  printf '\n'
''
