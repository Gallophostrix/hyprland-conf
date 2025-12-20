{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.bibata-cursors];

  wayland.windowManager.hyprland.settings.env = [
    "HYPRCURSOR_THEME,Bibata-Modern-Classic"
    "HYPRCURSOR_SIZE,26"
    "XCURSOR_THEME,Bibata-Modern-Classic"
    "XCURSOR_SIZE,26"
  ];
}
