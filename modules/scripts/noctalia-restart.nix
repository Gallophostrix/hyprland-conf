{pkgs, ...}:
pkgs.writeShellScriptBin "noctalia-restart" ''
  #!/usr/bin/env bash
  #
  # Returns pid and passes to `kill`
  pgrep -f noctalia-shell | xargs kill

  # Start noctalia-shell in background
  noctalia-shell > /dev/null 2>&1 &
''
