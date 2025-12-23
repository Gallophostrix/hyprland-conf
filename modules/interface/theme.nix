{...}: {
  stylix = {
    targets = {
      # Quickshell defined
      noctalia-shell.enable = false;
      gtk.enable = false;
      qt.enable = false;
      sway.enable = true;

      alacritty.enable = false;
      swaync.enable = false;
      yazi.enable = false;
      zed.enable = false;

      # Self defined
      fish.enable = false;

      # Unused
      waybar.enable = false;
      opencode.enable = false;

      # Stylix defined
      hyprland.enable = false;
      hyprlock = {
        enable = false;
        useWallpaper = true;
      };

      bat.enable = true;
      cava = {
        enable = true;
        rainbow.enable = true;
      };
      fzf.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      rofi.enable = true;

      anki.enable = true;
      obsidian.enable = true;
      spicetify.enable = true;
      zathura.enable = true;
    };
  };
}
