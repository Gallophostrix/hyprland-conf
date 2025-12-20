{...}: {
  fileSystems."/mnt/workload" = {
    device = "/dev/disk/by-uuid/b71184a8-6457-4156-8ea5-f5770ca14b4d";
    fsType = "ext4";
    options = [
      "rw"
      "noatime"
      "x-gvfs-show"
      "x-systemd.mount-timeout=5"
    ];
  };
}
