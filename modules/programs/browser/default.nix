{
  host,
  lib,
  hostVars,
  ...
}: {
  imports = [
    ./${hostVars.browser}/default.nix
  ];

  security.pki.certificates = lib.optional (builtins.pathExists "/etc/ssl/private/piCA.crt") (
    builtins.readFile "/etc/ssl/private/piCA.crt"
  );
}
