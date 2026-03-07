{
  pkgs,
  lib,
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
      vim_mode = false;
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
        env.TERM = "alacritty";
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
