{ pkgs, lib, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.zed-editor = {
        enable = true;

        extensions = [
          "nix"
          "python"
          "rust-analyzer"
          "yaml"
          "toml"
          "markdown"
        ];

        installRemoteServer = true;

        extraPackages = with pkgs; [
          nil
          alejandra
          rust-analyzer
          python312Packages.python-lsp-server
          nodejs
        ];

        userSettings = {
          vim_mode = false;
          base_keymap = "VSCode";
          load_direnv = "shell_hook";

          theme = {
            mode = "system";
            light = "Catppuccin Latte";
            dark = "Catppuccin Mocha";
          };

          telemetry = false;
          hour_format = "hour24";
          auto_update = false;
          show_whitespaces = "none";
          ui_font_size = 15;
          buffer_font_size = 15;

          terminal = {
            dock = "bottom";
            blinking = "off";
            copy_on_select = false;
            working_directory = "current_project_directory";
            env.TERM = "alacritty";
          };

          lsp = {
            nixd.binary.path_lookup = true;
            "rust-analyzer".binary.path_lookup = true; # clé avec tiret → guillemets
            "python-lsp-server".binary.path_lookup = true; # idem
          };

          assistant = {
            enabled = true;
            version = "2";
            default_model = {
              provider = "zed.dev";
              model = "claude-3-5-sonnet-latest";
            };
          };
        };

      };

      # Génère ~/.config/zed/keymap.json (format Zed)
      xdg.configFile."zed/keymap.json".text = builtins.toJSON [
        {
          bindings = {
          };
        }
        {
          context = "Editor";
          bindings = {
            "ctrl-/" = "editor::ToggleComments";
          };
        }
      ];

      programs.ssh.enable = true;
    })
  ];
}
