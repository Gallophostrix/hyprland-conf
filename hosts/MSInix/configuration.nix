{
  lib,
  hostVars,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/system
      ../../modules/scripts
      ../../modules/programs/misc/tlp
    ]
    ++ lib.optional (hostVars.games or false)
    ../../modules/system/hardware/gaming.nix;
}
