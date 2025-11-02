{pkgs, ...}: {
  # WM packages
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;

  # XDG Portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    # Extra portals for Hyprland and GTK
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    # Configuration packages for Hyprland
    configPackages = [pkgs.hyprland];
  };
}
