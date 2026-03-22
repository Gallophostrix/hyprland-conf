{pkgs, ...}: {
  hardware = {
    i2c.enable = true;
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
  };

  services = {
    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;

    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    udisks2.enable = true; # For Mounting USB & More
  };

  environment.systemPackages = [pkgs.ddcutil];
}
