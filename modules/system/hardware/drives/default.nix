{
  hostVars,
  lib,
  ...
}: {
  imports =
    [
      ./work.nix
      ./syncthing.nix
    ]
    ++ lib.optional (hostVars.data == true) ./data.nix
    ++ lib.optional (hostVars.workload == true) ./workload.nix;
}
