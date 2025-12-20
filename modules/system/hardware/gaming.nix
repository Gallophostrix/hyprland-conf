{pkgs, ...}: {
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
