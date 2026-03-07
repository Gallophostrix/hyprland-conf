{pkgs, ...}: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/home/mik/.ssh/id_ed25519"];
    secrets."tailscale/preauth_key" = {};
  };
}
