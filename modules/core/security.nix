{ pkgs, ... }:
{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
    pam.services.hyprlock = {
      text = ''
        auth      sufficient pam_fprintd.so
        auth      include    system-login
      '';
    };
  };
}
