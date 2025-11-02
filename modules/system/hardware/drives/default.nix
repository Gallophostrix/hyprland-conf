{
  hostVars,
  lib,
  ...
}: {
  imports =
    [
      # ./games.nix
      # ./work.nix
      ./syncthing.nix
    ]
    ++ lib.optional (hostVars.data == true) ./data.nix;
}
