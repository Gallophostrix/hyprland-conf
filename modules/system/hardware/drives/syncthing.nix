{
  host,
  hostVars,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "${hostVars.username}";
    dataDir = "/home/${hostVars.username}";
    configDir = "/home/${hostVars.username}/.config/syncthing";
  };
}
