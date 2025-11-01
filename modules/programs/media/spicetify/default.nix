{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  home.packages = [pkgs.spotify];

  # import the flake's module for your system
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    windowManagerPatch = config.wayland.windowManager.hyprland.enable;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      keyboardShortcut # vimium-like navigation
      copyLyrics # copy lyrics with selection
      beautiful-lyrics
      # autoVolume
      # showQueueDuration
      # fullAppDisplay
      # hidePodcasts
    ];
    enabledCustomApps = with spicePkgs.apps; [
      #   reddit
      #   lyricsPlus
      marketplace
      #   localFiles
      #   ncsVisualizer
    ];
  };
}
