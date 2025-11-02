{
  pkgs,
  lib,
  hostVars,
  ...
}: let
  inherit (hostVars) terminal;
in {
  programs.rofi = let
    inherit (lib) getExe;
  in {
    enable = true;
    terminal = "${getExe pkgs.${terminal}}";
    plugins = with pkgs; [
      rofi-emoji # https://github.com/Mange/rofi-emoji 🤯
      rofi-games # https://github.com/Rolv-Apneseth/rofi-games 🎮
    ];
    extraConfig = import ./config.nix;
  };
  xdg.configFile."rofi/launchers" = {
    source = ./launchers;
    recursive = true;
  };
  xdg.configFile."rofi/colors" = {
    source = ./colors;
    recursive = true;
  };
}
