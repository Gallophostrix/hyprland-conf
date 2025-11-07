{
  pkgs,
  lib,
  host,
  hostVars,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "${hostVars.sddmTheme}";
  };
in {
  environment.systemPackages = with pkgs; [
    sddm-astronaut # Sddm Theme (Overlayed)
    kdePackages.qtsvg # Sddm Dependency
    kdePackages.qtmultimedia # Sddm Dependency
    kdePackages.qtvirtualkeyboard # Sddm Dependency
  ];

  services.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      enableHidpi = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      extraPackages = with pkgs.qt6; [qtwayland qtmultimedia];
      settings.Theme.CursorTheme = "Bibata-Modern-Classic";
      theme = "sddm-astronaut-theme";
    };
  };
}
