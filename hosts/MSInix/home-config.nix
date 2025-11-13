{
  config,
  pkgs,
  hostVars,
  lib,
  inputs,
  ...
}: let
  username = hostVars.username;
  editor = hostVars.editor;
  terminal = hostVars.terminal;
  browser = hostVars.browser;
  shell = hostVars.shell;
in {
  imports =
    [
      ../../modules/system/hardware/video/gpu-offload.nix

      ../../modules/programs/browser/${browser}

      ../../modules/programs/cli/cava
      ../../modules/programs/cli/direnv
      ../../modules/programs/cli/lazygit
      ../../modules/programs/cli/shell/${shell}
      ../../modules/programs/cli/terminal/${terminal}
      ../../modules/programs/cli/yazi
      ../../modules/programs/cli/dev-tools.nix

      ../../modules/programs/editor/zeditor
      ../../modules/programs/editor/libreoffice

      ../../modules/programs/media/imv
      ../../modules/programs/media/mpv
      ../../modules/programs/media/spicetify
      ../../modules/programs/media/zathura

      ../../modules/programs/misc/thunar

      ../../modules/programs/desktop-apps.nix

      ../../modules/interface/interface.nix
      ../../modules/interface/theme.nix
      ../../modules/interface/desktop/hyprland
    ]
    ++ lib.optional (hostVars.games or false)
    ../../modules/programs/media/gaming.nix;

  gpuOffload = {
    apps = ["steam" "mpv"];
    vaapiApps = ["mpv"]; # launch with VA-API NVIDIA automatically
    addAliasNvo = true; # 'nvo' shortcut
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  xdg.enable = true;

  gtk.enable = true;
  # gtk.gtk3.extraConfig."gtk-font-name" = "Noto Sans 16";
  # gtk.gtk4.extraConfig."gtk-font-name" = "Noto Sans 16";

  home.sessionVariables = {
    EDITOR = editor;
    BROWSER = browser;
    TERMINAL = terminal;
  };

  programs.home-manager.enable = true;
}
