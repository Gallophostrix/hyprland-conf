{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    github-desktop
  ];
}
