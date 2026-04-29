{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    freetube
    obsidian
    sparrow
  ];
}
