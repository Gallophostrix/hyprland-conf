{lib, ...}: {
  fileSystems."/mnt/data" = lib.mkForce {
    device = "/dev/disk/by-uuid/5068984B68983228";
    fsType = "ntfs-3g";
    options = [
      "defaults"
      "uid=1000"
      "gid=100"
      "umask=0022"
      "windows_names"
      "big_writes"
      "nofail"
      "x-gvfs-show"
      "x-systemd.mount-timeout=5s"
      "x-mount.mkdir"
      # On-demand auto-mount + umount if unused
      # "x-systemd.automount"
      # "x-systemd.idle-timeout=30s"
    ];
  };
}
