{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # import the flake's module for your system
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      beautifulLyrics
      betterGenres
      copyLyrics # copy lyrics with selection
      shuffle # shuffle+ (special characters are sanitized out of ext names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      #   ncsVisualizer
    ];

    wayland = true;
  };
}
