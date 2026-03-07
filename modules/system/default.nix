{
  lib,
  hostVars,
  ...
}: {
  imports =
    [
      ./boot
      ./hardware
      ./network/network.nix
      ./network/ssh.nix
      ./devtools.nix
      ./flatpak.nix
      ./interface.nix
      ./monitoring.nix
      ./sddm.nix
      ./security.nix
      ./system.nix
      ./users.nix
      ./virtualisation.nix
    ]
    ++ lib.optional (hostVars.vpn or false)
    ./network/vpn.nix;
}
