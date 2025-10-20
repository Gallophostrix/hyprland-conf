{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Apps
    bitwarden-desktop
    github-desktop
    obsidian
    spotify
    # protonmail-bridge  # premium account required
    # Tools
    alejandra
    nixd
    wireguard-tools
  ];

  # systemd.user.services.protonmail-bridge = {
  # description = "ProtonMail Bridge (background service)";
  # after = [ "graphical-session.target" ];
  # wantedBy = [ "default.target" ];

  # serviceConfig = {
  # ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --no-window";
  # Restart = "on-failure";
  # StandardOutput = "journal";
  # StandardError = "journal";
  # };
  # };
}
