{
  lib,
  pkgs,
  config,
  hostVars,
  ...
}: let
  inherit
    (hostVars)
    browser
    terminal
    tuiFileManager
    editor
    kbdLayout
    kbdVariant
    defaultWallpaper
    ;

  inherit
    (lib)
    getExe
    getExe'
    ;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
      # inputs.hyprsysteminfo.packages.${pkgs.system}.default
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    extraConfig = ''
      source = ~/.config/hypr/hyprland-noctalia.conf
    '';
  };
}
