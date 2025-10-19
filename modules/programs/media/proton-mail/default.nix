{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    protonmail-desktop
    glib.bin

    (makeDesktopItem {
      name = "proton-mail";
      desktopName = "Proton Mail";
      genericName = "Email Client";
      comment = "Secure email by Proton";
      exec = "proton-mail %U";
      terminal = false;
      categories = ["Network" "Email"];
      mimeTypes = ["x-scheme-handler/mailto"];
      startupWMClass = "Proton Mail";
    })
  ];

  environment.etc."xdg/mimeapps.list".text = ''
    [Default Applications]
    x-scheme-handler/mailto=proton-mail.desktop
  '';

  environment.sessionVariables = {
    # >>> Fix Proton Mail Desktop "Missing proton-mail.desktop" <<<
    XDG_DATA_DIRS = lib.mkAfter [
      "${config.system.path}/share"
      "${pkgs.protonmail-desktop}/share"
      "/usr/local/share"
      "/usr/share"
    ];
  };

  # Autostart
  # systemd.user.services.proton-mail = {
  # description = "Proton Mail Desktop";
  # after = [ "graphical-session.target" ];
  # wantedBy = [ "default.target" ];
  # serviceConfig = {
  # ExecStart = "${pkgs.protonmail-desktop}/bin/proton-mail";
  # Restart = "on-failure";
  # };
  # };
}
