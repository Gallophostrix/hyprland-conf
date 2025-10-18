{ host, pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" ''
  #!/usr/bin/env bash
  set -euo pipefail

  RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

  if [[ ${EUID} -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting..."
    exit 1
  fi

  # Locate flake
  if [ -f "$HOME/NixOS/flake.nix" ]; then
    flake="$HOME/NixOS"
  elif [ -f "/etc/nixos/flake.nix" ]; then
    flake="/etc/nixos"
  else
    echo "Error: flake not found. ensure flake.nix exists in either $HOME/NixOS or /etc/nixos"
    exit 1
  fi

  echo -e "${GREEN}Flake: ${flake}${NC}"
  echo -e "${GREEN}Host: ${host}${NC}"

  currentUser="${SUDO_USER:-$USER}"

  # Safely replace username line (keep trailing semicolon)
  sudo sed -i -E \
    "s/username = \"[^\"]*\";/username = \"${currentUser}\";/" \
    "$flake/hosts/${host}/variables.nix"

  # Refresh hardware-configuration.nix in the flake
  if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    sudo tee "$flake/hosts/${host}/hardware-configuration.nix" >/dev/null < /etc/nixos/hardware-configuration.nix
  else
    sudo nixos-generate-config --show-hardware-config > "$flake/hosts/${host}/hardware-configuration.nix"
  fi

  sudo git -C "$flake" add "hosts/${host}/hardware-configuration.nix"

  # Rebuild & switch
  sudo nixos-rebuild switch --flake "$flake#${host}"

  echo -e "${GREEN}Done.${NC}"
''
