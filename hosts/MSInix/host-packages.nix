{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    github-desktop
    protonmail-bridge
  ];

  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "ProtonMail Bridge (background service)";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --no-window";
      Restart = "on-failure";

      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
