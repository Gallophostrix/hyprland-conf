{pkgs, ...}: {
  # WM packages
  programs.hyprland.enable = true;
  # XDG Portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    # Extra portals for Hyprland and GTK
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    # Configuration packages for Hyprland
    configPackages = [pkgs.hyprland];
  };

  # Yazi icons
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
