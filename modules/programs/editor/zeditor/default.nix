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
      "catppuccin"
      "catppuccin-icons"
      "sql"
      "dockerfile"
    ];

    installRemoteServer = true;

    extraPackages = with pkgs; [
      nil
      alejandra
    ];

    userSettings = {
      vim_mode = false;
      base_keymap = "VSCode";
      load_direnv = "shell_hook";

      ### System change !!! ###
      theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      icon_theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };

      telemetry = {
        diagnostics = true;
        metrics = true;
      };
      auto_update = true;
      show_whitespaces = "none";
      ui_font_size = 14;
      buffer_font_size = 13;
      buffer_font_family = "JetBrainsMono Nerd Font";

      terminal = {
        dock = "bottom";
        blinking = "off";
        copy_on_select = false;
        working_directory = "current_project_directory";
        env.TERM = "alacritty";
      };

      lsp = {
        nil = {
          settings = {
            nix = {
              flake = {
                autoArchive = true;
              };
            };
            formatting = {
              command = ["alejandra"];
            };
          };
        };
        "rust-analyzer" = {};
        "python-lsp-server" = {};
      };

      hour_format = "hour24";

      agent = {
        enabled = true;
        default_model = {
          provider = "OpenAI";
          model = "gpt-5";
        };
      };
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
