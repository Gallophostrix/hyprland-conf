{
  pkgs,
  lib,
  config,
  hostVars,
  host,
  ...
}: let
  terminal = hostVars.terminal;
  hostName = host;

  # Common args passed to each script builder
  scriptArgs = {
    inherit pkgs lib config terminal;
    host = hostName;
  };

  importScript = path: import path scriptArgs;

  scripts = [
    (importScript ./rollback.nix)
    (importScript ./extract.nix)
    (importScript ./driverinfo.nix)
    (importScript ./noctalia-restart.nix)
    # add more here
  ];
in {
  environment.systemPackages = scripts;
}
