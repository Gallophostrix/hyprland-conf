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
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
