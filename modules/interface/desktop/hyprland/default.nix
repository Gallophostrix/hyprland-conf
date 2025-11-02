{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./programs/rofi
    ./programs/waybar
    # ./programs/dunst
    ./programs/swaync
    ./programs/wlogout
    ./programs/hyprlock
    ./programs/hypridle
    ./programs/hyprsunset
    ./programs/hyprcursor
    ../../themes/Catppuccin # Catppuccin GTK and QT themes
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
    hyprpicker
    cliphist
    wf-recorder
    grimblast
    slurp
    libnotify
    brightnessctl
    networkmanagerapplet
    pamixer
    pavucontrol
    playerctl
    hyprshot
    wtype
    wl-clipboard
    yad
    # socat # for and autowaybar.sh
  ];

  xdg.configFile."hypr/icons" = {
    source = ./icons;
    recursive = true;
  };

  # Set wallpaper
  services.swww.enable = true;
}
