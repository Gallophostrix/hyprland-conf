{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    alejandra # Nix formatter
    nixd # Nix LSP
  ];
}
