{ host, pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" ''
  #!/usr/bin/env bash
  set -euo pipefail

  # Colors for output
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  NC='\033[0m' # No Color

  info()  { echo -e "\n${GREEN}$1${NC}"; }
  warn()  { echo -e "${YELLOW}$1${NC}"; }
  error() { echo -e "${RED}Error: $1${NC}" >&2; }

  generation="${1:-}"

  if [ -z "${generation}" ]; then
    error "Please provide a generation number (Use list-gens)"
    exit 1
  fi

  profile_link="/nix/var/nix/profiles/system-${generation}-link"
  swcfg_bin="${profile_link}/bin/switch-to-configuration"

  if [ ! -e "${profile_link}" ] || [ ! -x "${swcfg_bin}" ]; then
    error "Generation '${generation}' does not exist (or missing switch-to-configuration)"
    exit 1
  fi

  info "Generation: ${generation}"

  if command -v nh >/dev/null 2>&1; then
    nh os rollback -t "${generation}" || nh os switch -g "${generation}"
  else
    sudo "${swcfg_bin}" switch
  fi
''
