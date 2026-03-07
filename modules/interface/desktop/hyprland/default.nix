{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./noctalia.nix
    ./programs/cursor
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
    imagemagick
    python3
    gpu-screen-recorder

    hyprpicker
    grimblast
    slurp

    # audio
    pamixer
    pavucontrol
    playerctl
    hyprshot
  ];
}
