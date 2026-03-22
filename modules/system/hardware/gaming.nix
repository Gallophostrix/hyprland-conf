{pkgs, ...}: {
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
