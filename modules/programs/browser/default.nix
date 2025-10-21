{
  host,
  lib,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
in {
  imports = [
    ./${vars.browser}/default.nix
  ];

  security.pki.certificates =
    lib.optional (builtins.pathExists "/etc/ssl/private/piCA.crt")
    (builtins.readFile "/etc/ssl/private/piCA.crt");
}
