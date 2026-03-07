{pkgs, ...}: {
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
