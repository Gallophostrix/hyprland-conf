{lib, ...}: {
  fileSystems."/mnt/work" = {
    device = "/dev/disk/by-uuid/306E-2455";
    fsType = "vfat";
    options = [
      "defaults" # Default flags
      "async" # Run all operations async
      "nofail" # Don't error if not plugged in
      "x-gvfs-show" # Show in file explorer
      "x-systemd.mount-timeout=5" # Timout for error
      "X-mount.mkdir" # Make dir if it doesn't exist
      "uid=1000"
      "gid=100"
      "umask=002"
    ];
  };
}
