{pkgs, ...}: let
  themePath = import ./themes/xenlism.nix {inherit pkgs;};
in {
  boot = {
    # Filesystems support
    supportedFilesystems = [
      "ntfs"
      "exfat"
      "ext4"
      "vfat"
      "btrfs"
    ];

    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.
    kernelParams = [
      "preempt=full" # lower latency but less throughput
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"

      # ACPI workarounds for MSI Prestige / Meteor Lake
      "acpi_mask_gpe=0x6F"
      "acpi_enforce_resources=lax"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = null; # Display bootloader indefinitely until user selects OS

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

        gfxmodeEfi = "3840x2160,2560x1440,1920x1080,auto";
        gfxpayloadEfi = "keep";

        theme = themePath;
      };
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
