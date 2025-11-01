{
  host,
  lib,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
in {
  imports =
    [
      # ./games.nix
      # ./work.nix
      ./syncthing.nix
    ]
    ++ lib.optional (vars.data == true) ./data.nix;
}
