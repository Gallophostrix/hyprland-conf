{
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm; # KVM acceleration
      swtpm.enable = true; # Secure Trusted Platform Module (Windows)
      ovmf = {
        enable = true; # UEFI firmware
        packages = [pkgs.OVMFFull.fd];
      };
    };
  };

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
