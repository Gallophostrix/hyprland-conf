{pkgs, ...}: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam.services.hyprlock = {
      text = ''
        auth      sufficient pam_fprintd.so
        auth      include    system-login
        account   include    system-login
        password  include    system-login
        session   include    system-login
      '';
    };
  };

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };

  services.gnome.gnome-keyring.enable = true;
}
