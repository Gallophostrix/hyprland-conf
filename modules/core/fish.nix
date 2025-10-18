{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    # Aliases
    shellAliases = {
      l    = "eza -lh --icons=auto";
      ls   = "eza -1 --icons=auto";
      ll   = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld   = "eza -lhD --icons=auto";
      tree = "eza --icons=auto --tree";
      vc   = "codium --disable-gpu";
      nf   = "microfetch";
      cp   = "cp -iv";
      mv   = "mv -iv";
      rm   = "rm -vI";
      bc   = "bc -ql";
      mkd  = "mkdir -pv";
      tp   = "trash-put";
      tpr  = "trash-restore";
      grep = "grep --color=always";
      "list-gens"   = "nixos-rebuild list-generations";
      "update-input"= "nix flake update";
      sysup         = "nix flake update --flake ~/nixcfg && rebuild";
      games   = "cd /mnt/games/";
      work    = "cd /mnt/work/";
      media   = "cd /mnt/work/media/";
      projects= "cd /mnt/work/Projects/";
      proj    = "cd /mnt/work/Projects/";
      dev     = "cd /mnt/work/Projects/";
    };

    interactiveShellInit = ''
      if status is-interactive
        if type -q direnv
          direnv hook fish | source
        end
        if type -q zoxide
          zoxide init fish | source
        end

        bind \ca beginning-of-line
        bind \ce end-of-line

        set -g fish_autosuggestion yes
        set -g fish_history_size 100000
        set -g fish_history "$XDG_DATA_HOME/fish/history"
        set -g fish_prompt_subst yes
        set -g fish_always_to_end yes
        set -g fish_append_history yes
        set -g fish_auto_menu yes
        set -g fish_complete_in_word yes
        set -g fish_extended_history yes
        set -g fish_hist_expire_dups_first yes
        set -g fish_hist_ignore_dups yes
        set -g fish_hist_ignore_space yes
        set -g fish_hist_verify yes
        set -g fish_inc_append_history yes
        set -g fish_share_history yes

        set -gx XMONAD_CONFIG_DIR (set -q XDG_CONFIG_HOME; or echo ~/.config)/xmonad
        set -gx XMONAD_DATA_DIR   (set -q XDG_DATA_HOME;  or echo ~/.local/share)/xmonad
        set -gx XMONAD_CACHE_DIR  (set -q XDG_CACHE_HOME; or echo ~/.cache)/xmonad
        set -gx FZF_DEFAULT_OPTS "--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

        function UUID; uuidgen | tr -d \n; end
        alias lf 'set tmp (mktemp); command lf -last-dir-path="$tmp" $argv; if test -f "$tmp"; rm -f "$tmp"; set dir (cat $tmp); if test -d $dir; cd $dir; end'
        alias fnew 'if test -d $argv[2]; echo "Directory $argv[2] already exists!"; return 1; end; nix flake new $argv[2] --template ~/N/dev-shells#$argv[1]; cd $argv[2]; direnv allow'
        alias finit 'nix flake init --template ~/N/dev-shells#$argv[1]; direnv allow'
        alias cdown 'set N $argv[1]; while test $N -gt 0; echo (figlet -c $N | lolcat); sleep 1; set N (math $N - 1); end'
        alias tml "tmux list-sessions"
        alias tma "tmux attach"
        alias tms "tmux attach -t (tmux ls -F '#{session_name}: #{session_path} (#{session_windows} windows)' | fzf | cut -d: -f1)"
      end
    '';
  };

  environment.systemPackages = with pkgs; [
    eza trash-cli microfetch figlet lolcat fzf tmux lf direnv zoxide
  ];

  # Auto hooks
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zoxide.enable = true;
}
