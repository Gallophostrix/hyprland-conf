{
  lib,
  hostVars,
  inputs,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix

      inputs.stylix.nixosModules.stylix
      ../../modules/interface/stylix.nix

      ../../modules/system
      ../../modules/scripts
      ../../modules/programs/misc/tlp
    ]
    ++ lib.optional (hostVars.games or false)
    ../../modules/system/hardware/gaming.nix;
}
