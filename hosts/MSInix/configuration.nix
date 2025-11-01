{...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/system
    ../../modules/scripts
    ../../modules/programs/misc/tlp

    ./host-packages.nix
  ];
}
