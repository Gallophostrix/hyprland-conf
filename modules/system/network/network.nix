{hostVars, ...}: {
  networking = {
    hostName = hostVars.hostname;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH (Secure Shell) - remote access
      ];
      allowedUDPPorts = [];
    };
  };

  networking.nftables.enable = true;
}
