{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-desktop
    github-desktop
    obsidian
  ];
}
