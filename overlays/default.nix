{
  inputs,
  host,
}: {
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  additions = final: prev: {
    # From own packages
    # mon-package = final.callPackage ../pkgs/mon-package {};
    #  From external modules
    # inherit (inputs.nur.packages.${final.system}) some-nur-pkg;
  };

  # Patch an existing package into nixpkgs
  modifications = final: prev: {
    # discord = prev.discord.overrideAttrs (old: { ... });
  };

  millennium = inputs.millennium.overlays.default;
}
