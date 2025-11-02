{
  lib,
  pkgs,
  config,
  ...
}: {
  # Use NVIDIA driver (required to make the dGPU available for offloading).
  # The Intel iGPU (i915) is present anyway; Wayland compositors use it without X.org drivers.
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = true; # Open kernel modules (fine for RTX 4060)
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true; # Required for Wayland/PRIME
    nvidiaSettings = true; # Handy diagnostics tool
    powerManagement.enable = true; # Powers down dGPU when idle; better suspend/resume

    # Hybrid laptop: iGPU for desktop, dGPU on demand via `nvidia-offload <cmd>`
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0"; # from your lspci (Intel Arc iGPU)
      nvidiaBusId = "PCI:1:0:0"; # from your lspci (RTX 4060 dGPU)
    };
  };

  # Wayland + PRIME necessities; preserve VRAM across suspend helps on many laptops.
  # boot.kernelParams = [
  #   "nvidia-drm.modeset=1"
  #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  # ];

  # Graphics stack (32-bit for Steam/Proton). Provide both Intel & NVIDIA VA-API bits.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # Intel Xe/Arc (iHD) VA-API driver (use this on Meteor Lake)
      nvidia-vaapi-driver # VA-API on NVIDIA via NVDEC/NVENC (optional but useful)
    ];
  };

  # Optional: only if you hit cursor glitches with NVIDIA on wlroots
  # environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  # CPU thermal management on Intel (recommended for laptops).
  services.thermald.enable = true;

  # Enable this only if you know your platform benefits from it (mostly some ThinkPads).
  # services.throttled.enable = true;

  # If you had Intel kernel params: many are optional; keep only those you actually need.
  # Example (use cautiously; modern kernels often auto-tune these):
  # boot.kernelParams = boot.kernelParams ++ [
  #   "i915.enable_guc=2"   # GuC submission (may help for media/compute scheduling)
  #   "i915.enable_psr=1"   # Panel Self Refresh (saves power; disable if you see flicker)
  #   "i915.enable_fbc=1"   # Framebuffer compression (saves power)
  #   "i915.fastboot=1"     # Faster boot modesets
  #   "mem_sleep_default=deep"
  # ];
}
