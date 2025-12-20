{
  pkgs,
  hostVars,
  ...
}: {
  networking = {
    hostName = hostVars.hostname;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH (Secure Shell) - remote access
        80 # HTTP - web traffic
        443 # HTTPS - encrypted web traffic
        59010 # Custom application port
        59011 # Custom application port
        8080 # Alternative HTTP/web server port
      ];
      allowedUDPPorts = [
        59010 # Custom application port
        59011 # Custom application port
      ];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = true;
}
