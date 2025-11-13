{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # import the flake's module for your system
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;
    windowManagerPatch = false;

    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
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
