{pkgs, ...}: {
  imports = [
    ./boot
    ./hardware
    ./network/network.nix
    ./network/ssh.nix
    ./network/wireguard.nix
    ./devtools.nix
    ./flatpak.nix
    ./fonts.nix
    ./interface.nix
    ./sddm.nix
    ./security.nix
    ./system.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
