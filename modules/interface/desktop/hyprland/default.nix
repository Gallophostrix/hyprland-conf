{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./noctalia.nix
    ./programs/rofi
    ./programs/hyprlock
    ./programs/hypridle
    ./programs/hyprcursor
  ];
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprpolkitagent - Polkit authentication agent";
      After = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
  };

  home.packages = with pkgs; [
    # quickshell dependencies
    quickshell
    gpu-screen-recorder
    brightnessctl

    ddcutil

    cliphist
    matugen
    wlsunset

    # GTK theming
    nwg-look
    adw-gtk3

    hyprpicker
    wf-recorder
    grimblast
    slurp
    pamixer
    pavucontrol
    playerctl
    hyprshot
    wtype
    # wl-clipboard
    yad
  ];

  xdg.configFile."hypr/icons" = {
    source = ./icons;
    recursive = true;
  };

  # Set wallpaper
  services.swww.enable = true;
}
