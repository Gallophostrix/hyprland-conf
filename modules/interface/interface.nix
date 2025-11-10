{
  host,
  pkgs,
  config,
  lib,
  ...
}: {
  # Required packages for the interface and themes
  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-kvantum
    papirus-icon-theme
    bibata-cursors
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };
  gtk = {
    enable = true;
    gtk2.force = true;
    iconTheme = {
      # package = pkgs.adwaita-icon-theme;
      # name = "Adwaita";
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
    };
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = lib.mkDefault pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = lib.mkDefault 24;
  };
}
