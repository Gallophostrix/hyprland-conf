{
  pkgs,
  lib,
  hostVars,
  ...
}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "yaml"
      "toml"
      "markdownlint"
      "sql"
      "dockerfile"
      "git-firefly"
      "catppuccin-icons"
    ];

    extraPackages = with pkgs; [
      nixd
    ];

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      auto_update = false;

      vim = {
        enable = true;
        use_smartcase_find = true;
        toggle_relative_line_numbers = true;
        enable_vim_sneak = true;
      };

      scrollbar = {show = "never";};
      tabs = {show_diagnostics = "errors";};
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      theme = {
        mode = "dark";
        light = "Noctalia Light";
        dark = "Noctalia Dark";
      };
      icon_theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      ui_font_size = lib.mkForce 14;
      buffer_font_size = lib.mkForce 13;
      buffer_font_family = "JetBrainsMono Nerd Font";

      base_keymap = "VSCode";
      show_whitespaces = "none";
      cursor_position_button = false;
      debugger = {button = false;};
      search = {button = false;};
      tab_bar = {show_nav_history_buttons = false;};
      outline_panel = {button = false;};
      window_decorations = "server";

      languages = {
        Nix = {
          language_servers = ["nixd"];
        };
      };
      lsp = {
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = ["alejandra"];
              };
            };
          };
        };
      };

      terminal = {
        dock = "bottom";
        blinking = "off";
        copy_on_select = false;
        working_directory = "current_project_directory";
        env.TERM = hostVars.terminal;
      };

      load_direnv = "shell_hook";

      # agent = {
      #   enabled = true;
      #   default_model = {
      #     provider = "OpenAI";
      #     model = "gpt-5";
      #   };
      # };
    };

    userKeymaps = [
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "shift-h" = "pane::ActivatePreviousItem";
          "shift-l" = "pane::ActivateNextItem";
          "shift-q" = "pane::CloseActiveItem";
          "space space" = "file_finder::Toggle";
          "space /" = "pane::DeploySearch";
          "ctrl-s" = "workspace::Save";
          "space p" = "workspace::ToggleLeftDock";
          "ctrl-t" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Editor && vim_mode == insert && !menu";
        bindings = {
          "j j" = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "ctrl-t" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-t" = "terminal_panel::ToggleFocus";
          "ctrl-k" = "workspace::ActivatePaneUp";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "a" = "project_panel::NewFile";
          "A" = "project_panel::NewDirectory";
          "r" = "project_panel::Rename";
          "d" = "project_panel::Delete";
          "x" = "project_panel::Cut";
          "c" = "project_panel::Copy";
          "p" = "project_panel::Paste";
          "q" = "workspace::ToggleLeftDock";
        };
      }
      {
        context = "vim_mode == normal || vim_mode == visual";
        bindings = {
          "s" = ["vim::PushSneak" {}];
          "S" = ["vim::PushSneakBackward" {}];
        };
      }
    ];
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      hashKnownHosts = true;
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
    };
  };
}
