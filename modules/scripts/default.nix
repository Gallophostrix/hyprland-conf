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
    (importScript ./rebuild.nix)
    (importScript ./rollback.nix)
    (importScript ./launcher.nix)
    (importScript ./extract.nix)
    (importScript ./driverinfo.nix)
    (importScript ./underwatt.nix)
    # add more here
  ];
in {
  environment.systemPackages = scripts;
}
