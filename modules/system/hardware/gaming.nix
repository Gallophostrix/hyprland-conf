{pkgs, ...}: {
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    # Graphical server for video games
    gamescope = {
      enable = false;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
        "-W"
        "2560"
        "-H"
        "1600"
      ];
    };
  };
}
