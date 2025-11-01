{
  self,
  pkgs,
  ...
}: {
  imports = [
    ../packages.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFileSize = 100000;
    initExtra = ''
      # Starship Prompt
      if command -v starship &>/dev/null; then
      eval "$(starship init bash)"
      fi

      # Direnv Hook
      if command -v direnv &>/dev/null; then
      eval "$(direnv hook bash)"
      fi
    '';
    # bashrcExtra = ''
    #   export TERM="xterm-256color" # Get correct colour
    # '';
    shellOptions = [
      "autocd" # change to named directory
      "cdspell" # autocorrects cd misspellings
      "cmdhist" # save multi-line commands in history as single line
      "dotglob"
      "histappend" # do not overwrite history
      "expand_aliases" # expand aliases
      "checkwinsize" # checks term size when bash regains control
    ];
    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'';
    };
    shellAliases = {
      lf = ''
        {
        tmp="$(mktemp)"
        # `command` is needed in case `lfcd` is aliased to `lf`
        command lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
        if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
        fi
        fi
        fi
        }
      '';
      fnew = ''
        if [ -d "$2" ]; then
        echo "Directory \"$2\" already exists!"
        return 1
        fi
        nix flake new $2 --template ${self}/dev-shells#$1
        cd $2
        direnv allow
      '';

      finit = ''
        nix flake init --template ${self}/dev-shells#$1
        direnv allow
      '';
      cdown = ''
        N=$1
        while [[ $((--N)) -gt  0 ]]
        do
        echo "$N" |  figlet -c | lolcat &&  sleep 1
        done
      '';
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      bc = "bc -ql";
      mkd = "mkdir -pv";
      grep = "grep --color=always";

      # Nixos
      list-gens = "nixos-rebuild list-generations";
      find-store-path = ''function { nix-shell -p $1 --command "nix eval -f \"<nixpkgs>\" --raw $1" }'';
      update-input = "nix flake update $@";
      sysup = "nix flake update --flake ~/NixOS && rebuild";

      # Directory Shortcuts.
      dots = "z ~/NixOS/";
      games = "z /mnt/games/";
      work = "z /mnt/work/";
    };
  };
}
