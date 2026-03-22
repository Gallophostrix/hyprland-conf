{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      selection = {
        save_to_clipboard = false;
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      };
      window = {
        decorations = "none";
        dynamic_padding = true;
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        dimensions = {
          columns = 100;
          lines = 30;
        };
        padding = {
          x = 10;
          y = 10;
        };
      };
      general.import = [
        "~/.config/alacritty/alacritty-noctalia.toml"
      ];
    };
  };
}
