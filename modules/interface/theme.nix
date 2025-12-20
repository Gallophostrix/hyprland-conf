{...}: {
  stylix = {
    targets = {
      gtk.enable = true;
      qt.enable = true;
      sway.enable = true;

      hyprland.enable = true;
      hyprlock = {
        enable = false;
        useWallpaper = true;
      };
      swaync.enable = true;
      waybar = {
        enable = true;
        addCss = false;
      };

      alacritty.enable = true;
      bat.enable = true;
      cava = {
        enable = true;
        rainbow.enable = true;
      };
      fzf.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      rofi.enable = true;
      yazi.enable = true;

      anki.enable = true;
      obsidian.enable = true;
      spicetify.enable = true;
      zed.enable = true;
      zathura.enable = true;

      opencode.enable = false;
      fish.enable = false;
    };
  };
}
