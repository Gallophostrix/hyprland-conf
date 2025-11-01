{
  pkgs,
  lib,
  hostVars,
  ...
}: {
  imports =
    [
      ./drives
      ./video/msi-setup.nix
      ./audio.nix
      ./bluetooth.nix
      ./tools.nix
    ]
    ++ lib.optional (hostVars.games or false)
    ./gaming.nix;
}
