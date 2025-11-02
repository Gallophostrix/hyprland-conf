{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.bibata-cursors];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 26;
    gtk.enable = true;
    x11.enable = true;
  };

  wayland.windowManager.hyprland.settings.env = [
    "HYPRCURSOR_THEME,Bibata-Modern-Classic"
    "HYPRCURSOR_SIZE,26"
    "XCURSOR_THEME,Bibata-Modern-Classic"
    "XCURSOR_SIZE,26"
  ];
}
