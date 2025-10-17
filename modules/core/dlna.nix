{ ... }:
{

  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "NixOS-DLNA";
      media_dir = [
        # A = Audio, P = Pictures, V, = Videos, PV = Pictures and Videos.
        # "A,/mnt/work/Pimsleur/Russian"
        # "V,/mnt/work/Pimsleur"
        "V,/mnt/work/Media/Films"
        "V,/mnt/work/Media/Series"
        "V,/mnt/work/Media/Videos"
        "A,/mnt/work/Media/Music"
      ];
      inotify = "yes";
      log_level = "error";
    };
  };
  users.users.minidlna = {
    extraGroups = [ "users" ]; # so minidlna can access the files.
  };
}
