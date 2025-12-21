{pkgs, ...}: {
  imports = [
    ../packages.nix
  ];

  programs.fish = {
    enable = true;

    # Aliases
    shellAliases = {
      l = "eza -lh --icons=auto";
      ls = "eza -1 --icons=auto";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld = "eza -lhD --icons=auto";
      tree = "eza --icons=auto --tree";
      nf = "microfetch";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      bc = "bc -ql";
      mkd = "mkdir -pv";
      tp = "trash-put";
      tpr = "trash-restore";
      grep = "rg --color always";
      rg = "rg --color always";
      "list-gens" = "nixos-rebuild list-generations";
      "update-input" = "nix flake update";
      sysup = "nix flake update --flake ~/nixcfg && rebuild";
      games = "cd /mnt/games/";
      work = "cd /mnt/work/";
      media = "cd /mnt/work/media/";
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

        set -g fish_greeting
        set -g fish_autosuggestion yes
        set -g fish_history_size 100000
        if not set -q fish_history
         set -U fish_history fish
        end
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
        functions -e lf 2>/dev/null
        function lf --description 'lf + cd to last dir' --wraps lf
          set -l tmp (mktemp)
          command lf -last-dir-path="$tmp" $argv

          set -l dir ""
          if test -f "$tmp"
            set dir (string trim (cat "$tmp"))
            rm -f "$tmp"
          end

          if test -n "$dir"; and test -d "$dir"
            cd "$dir"
          end
        end

        functions -e cdown 2>/dev/null
        function cdown --description 'Countdown with figlet+lolcat'
          set -l N (math "int($argv[1] 2>/dev/null)")
          if test -z "$N"; or test "$N" -le 0
            echo "Usage: cdown <seconds>"
            return 1
          end
          while test $N -gt 0
            echo (figlet -c $N | lolcat)
            sleep 1
            set N (math $N - 1)
          end
        end

        functions -e fnew 2>/dev/null
        function fnew --description 'Create flake from template and cd into it'
          if test (count $argv) -lt 2
            echo "Usage: fnew <template> <dir>"
            return 1
          end
          set -l template $argv[1]
          set -l dir      $argv[2]

          if test -d "$dir"
            echo "Directory $dir already exists!"
            return 1
          end

          nix flake new "$dir" --template ~/N/dev-shells#"$template"
          cd "$dir"
          direnv allow
        end

        functions -e finit 2>/dev/null
        function finit --description 'Init flake from template in current dir'
          if test (count $argv) -lt 1
            echo "Usage: finit <template>"
            return 1
          end
          nix flake init --template ~/N/dev-shells#"$argv[1]"
          direnv allow
        end

        alias tml "tmux list-sessions"
        alias tma "tmux attach"
        alias tms "tmux attach -t (tmux ls -F '#{session_name}: #{session_path} (#{session_windows} windows)' | fzf | cut -d: -f1)"

        # --- Universal vars (colors, pager, prompt), set-once/idempotent ---
        function __ensure_uvar
          set -l name $argv[1]
          set -e argv[1]
          if not set -q $name
            # Stocke toutes les valeurs restantes comme liste
            set -U $name $argv
          end
        end

        __ensure_uvar __fish_initialized 3400
        __ensure_uvar fish_color_autosuggestion 969896
        __ensure_uvar fish_color_cancel --reverse
        __ensure_uvar fish_color_command b294bb
        __ensure_uvar fish_color_comment f0c674
        __ensure_uvar fish_color_cwd green
        __ensure_uvar fish_color_cwd_root red
        __ensure_uvar fish_color_end b294bb
        __ensure_uvar fish_color_error cc6666
        __ensure_uvar fish_color_escape 00a6b2
        __ensure_uvar fish_color_history_current --bold
        __ensure_uvar fish_color_host --bold
        __ensure_uvar fish_color_host_remote --bold yellow
        __ensure_uvar fish_color_keyword b294bb
        __ensure_uvar fish_color_match --background=brblue
        __ensure_uvar fish_color_normal normal
        __ensure_uvar fish_color_operator 00a6b2
        __ensure_uvar fish_color_option 81a2be
        __ensure_uvar fish_color_param 81a2be
        __ensure_uvar fish_color_quote b5bd68
        __ensure_uvar fish_color_redirection 8abeb7
        __ensure_uvar fish_color_search_match bryellow --background=brblack
        __ensure_uvar fish_color_selection white --bold --background=brblack
        __ensure_uvar fish_color_status red
        __ensure_uvar fish_color_user --bold green
        __ensure_uvar fish_color_valid_path --underline
        __ensure_uvar fish_key_bindings fish_default_key_bindings
        __ensure_uvar fish_pager_color_background ""
        __ensure_uvar fish_pager_color_completion normal
        __ensure_uvar fish_pager_color_description B3A06D
        __ensure_uvar fish_pager_color_prefix normal --bold --underline
        __ensure_uvar fish_pager_color_progress brwhite --background=cyan
        __ensure_uvar fish_pager_color_secondary_background ""
        __ensure_uvar fish_pager_color_secondary_completion ""
        __ensure_uvar fish_pager_color_secondary_description ""
        __ensure_uvar fish_pager_color_secondary_prefix ""
        __ensure_uvar fish_pager_color_selected_background --background=brblack
        __ensure_uvar fish_pager_color_selected_completion ""
        __ensure_uvar fish_pager_color_selected_description ""
        __ensure_uvar fish_pager_color_selected_prefix ""
        __ensure_uvar fish_prompt_transient_enable 1


      end
    '';
  };
}
