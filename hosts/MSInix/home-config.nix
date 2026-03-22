{
  hostVars,
  lib,
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

      ../../modules/programs/cli/direnv
      ../../modules/programs/cli/shell/${shell}
      ../../modules/programs/cli/terminal/${terminal}
      ../../modules/programs/cli/yazi
      ../../modules/programs/cli/dev-tools.nix

      ../../modules/programs/editor/zeditor

      ../../modules/programs/media/freetube
      ../../modules/programs/media/imv
      ../../modules/programs/media/mpv
      ../../modules/programs/media/spicetify
      ../../modules/programs/media/zathura

      ../../modules/programs/misc/thunar

      ../../modules/programs/desktop-apps.nix

      ../../modules/interface/interface.nix
      ../../modules/interface/desktop/hyprland
    ]
    ++ lib.optional (hostVars.games or false)
    ../../modules/programs/media/gaming.nix;

  gpuOffload = {
    apps = ["mpv"];
    vaapiApps = ["mpv"]; # launch with VA-API NVIDIA automatically
    addAliasNvo = true; # 'nvo' shortcut
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };

  xdg = {
    enable = true;
    autostart.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "video/mp4" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "com.collabora.Office.desktop";
      };
    };
  };

  gtk.enable = true;

  home.sessionVariables = {
    EDITOR = editor;
    BROWSER = browser;
    TERMINAL = terminal;
  };

  programs.home-manager.enable = true;
}
