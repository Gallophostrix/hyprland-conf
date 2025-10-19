{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    obsidian
    github-desktop
    # protonmail-bridge  # premium account required
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
