{pkgs, ...}: {
  # WM packages
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

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

  # Icons and foreign characters
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
  ];
}
