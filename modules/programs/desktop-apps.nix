{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    freetube
    github-desktop
    obsidian
    sparrow
  ];
}
