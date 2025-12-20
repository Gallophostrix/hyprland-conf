{
  host,
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  # Required packages for the interface and themes
  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-kvantum
    papirus-icon-theme
    bibata-cursors
  ];

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style.name = "kvantum";
  # };
  gtk = {
    enable = true;
    gtk2.force = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
