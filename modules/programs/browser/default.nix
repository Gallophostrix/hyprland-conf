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
    lib.optional (builtins.pathExists "/etc/CA/rootCA.pem")
    (builtins.readFile "/etc/CA/rootCA.pem");
}
