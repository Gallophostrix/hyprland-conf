{ ... }:
{
  imports = [
    ./games.nix
    ./work.nix
    ./hardware/private.nix
    (lib.optional (builtins.pathExists ./hardware/private.nix))
  ];
}
