{
  lib,
  pkgs,
  config,
  ...
}: {
  # Load the proprietary NVIDIA driver and enable DRM modesetting.
  # Required for Wayland/wlroots compositors (e.g., Hyprland) and PRIME offload.
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Use NVIDIA "open" kernel modules (supported on 20/30/40-series incl. RTX 4060).
    # Switch to false if you hit a rare compatibility issue.
    open = true;

    # Choose the driver channel (stable is recommended).
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Required for Wayland/PRIME.
    modesetting.enable = true;

    # Install nvidia-settings (handy for diagnostics; mostly X11-oriented but still useful).
    nvidiaSettings = true;

    # Power management for laptops (helps sleep/suspend and powers down the dGPU when idle).
    powerManagement.enable = true;

    # Hybrid laptop: iGPU handles the desktop, dGPU is used on demand (PRIME offload).
    prime = {
      offload.enable = true; # provides the `nvidia-offload` wrapper
      intelBusId = "PCI:0:2:0"; # from `lspci` (your Intel iGPU)
      nvidiaBusId = "PCI:1:0:0"; # from `lspci` (your NVIDIA dGPU)
    };
  };

  # Kernel parameters:
  # - nvidia-drm.modeset=1: enable DRM KMS for NVIDIA (Wayland/PRIME requirement)
  # - NVreg_PreserveVideoMemoryAllocations=1: improves resume from suspend on some laptops
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # Generic graphics stack (32-bit for Steam/Proton).
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # VAAPI on NVIDIA via NVDEC/NVENC. Optional; keep if you use VAAPI.
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      # Generally not needed on NVIDIA:
      # vaapiVdpau
      # libvdpau-va-gl
    ];
  };

  # Don't force global NVIDIA-specific environment variables.
  # They can break Intel VA-API or cause unintended behavior for Wayland apps.
  # If you encounter cursor glitches: uncomment the next line.
  # environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  # Allow only the minimal set of unfree NVIDIA bits.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

  # CUDA is only needed if you actually do GPU compute/AI/HPC. Otherwise, keep it off.
  # nixpkgs.config.cudaSupport = true
  # nix.settings = {
  #   substituters = [ "https://cuda-maintainers.cachix.org" ];
  #   trusted-public-keys = [
  #     "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
  #   ];
  # };
}
