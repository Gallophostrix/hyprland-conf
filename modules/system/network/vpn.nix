{
  pkgs,
  hostVars,
  config,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    authKeyFile = config.sops.secrets."tailscale/preauth_key".path;
    extraUpFlags = [
      "--exit-node=100.64.0.3"
      "--exit-node-allow-lan-access"
      "--accept-routes"
      "--accept-dns"
    ];
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = ["1.1.1.1" "8.8.8.8"];
  };
}
