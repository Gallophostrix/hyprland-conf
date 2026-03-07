{
  hostVars,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/home/${hostVars.username}/nixcfg";
  };

  environment.systemPackages = with pkgs; [
    sops # secret encryption tool
    age # age encryption tool

    lm_sensors # get hardware stats
    nix-prefetch-scripts # Find Hashes/Revisions of Nix Packages
    usbutils # get usb device info
    git
    gh

    appimage-run # AppImage runner
    killall # kill all processes
    libjxl # JXL support
  ];
}
