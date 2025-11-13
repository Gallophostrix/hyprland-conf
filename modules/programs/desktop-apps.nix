{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    github-desktop
    obsidian
  ];
}
