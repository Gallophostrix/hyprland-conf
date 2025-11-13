{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.alacritty = let
    inherit (lib) getExe;
  in {
    enable = true;
    settings = {
      # ---- Theme ----
      # general.import = [
      #   "${config.home.homeDirectory}/.config/theme-current/programs/cli/alacritty/colors.toml"
      # ];

      # font.size = 12.0;

      window = {
        decorations = "full";
        dynamic_padding = true;
        startup_mode = "Maximized";

        padding.x = 10;
        padding.y = 10;
        dimensions.columns = 100;
        dimensions.lines = 30;
        class.general = "Alacritty";
        class.instance = "Alacritty";
      };

      terminal.shell = {
        program = "${getExe pkgs.fish}";
      };

      keyboard.bindings = [
        {
          chars = "cd $(${getExe pkgs.fd} . /mnt/work /mnt/work/dev/ /run /run/current-system ~/.local/ ~/ --max-depth 2 | fzf)\r";
          key = "F";
          mods = "Control";
        }
        {
          action = "Paste";
          key = "Y";
          mods = "Control";
        }
        {
          action = "Copy";
          key = "W";
          mods = "Alt";
        }
        {
          action = "SpawnNewInstance";
          key = "Return";
          mods = "Super|Shift";
        }
      ];

      selection = {
        save_to_clipboard = false;
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };
    };
  };
}
