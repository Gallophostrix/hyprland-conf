{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # image = ./themes/wallpapers/evening-sky.webp;
    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 26;
    };
    targets = {
      gtk.enable = true;
      qt.enable = true;
      sway.enable = true;
      alacritty.enable = true;
      hyprland.enable = true;
      hyprlock.enable = true;
      # waybar.enable = true;
      zed.enable = true;
    };
  };
}
