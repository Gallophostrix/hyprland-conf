{ pkgs, ... }: {
  home-manager.sharedModules = [
    (import ./module.nix)
    (_: {
      programs.zed = {
        enable = true;
        package = pkgs.zed-editor;

        # Équivalents “visuels / workflow” à la VSCode, version Zed
        settings = {
          theme = "Catppuccin Mocha";
          font_size = 14;
          telemetry = false;
          wrap = true;                 # word wrap
          line_numbers = true;
          show_whitespace = false;
          cursor_blink = true;
          auto_save = "afterDelay";    # or "onFocusChange" / "off"
          # Exemple LSP (si activé côté Zed)
          lsp = {
            nixd = {
              command = "nixd";
              settings.formatting.command = [ "alejandra" ];
            };
            ruff = { command = "ruff"; };
          };
        };

        # Essaie ces commandes ; ajuste si besoin via la palette de Zed
        keymap = [
          { key = "ctrl+s"; command = "workbench.save_all"; }
          { key = "ctrl+q"; command = "editor.toggle_line_comment"; when = "editor_focus"; }
        ];

        # Optionnel : extensions à pré-déclarer
        extensions = [
          "nix"
          "python"
          "rust-analyzer"
          "yaml"
          "toml"
          "markdown"
        ];
      };
    })
  ];
}
