{
  description = "NixOS config + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    thunderbird-catppuccin = {
      url = "github:catppuccin/thunderbird";
      flake = false;
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
  };

  # flake.nix (outputs section)
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      inherit (nixpkgs.lib) genAttrs;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = genAttrs systems;
      pkgsFor = system: import nixpkgs { inherit system; };

      # Helper to create NixOS hosts
      mkHost =
        host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Use ONE of these depending on your structure:
            ./hosts/${host}/configuration.nix # (folder-based)

            # Optional: enable Hyprland flake module
            # hyprland.nixosModules.default
          ];

          specialArgs = {
            overlays = import ./overlays { inherit inputs host; };
            inherit self inputs host;
          };
        };
    in
    {
      # Dev environment templates
      templates = import ./dev-shells;

      # Formatter per system
      formatter = forAllSystems (system: (pkgsFor system).nixfmt-tree);

      # NixOS host definitions
      nixosConfigurations = {
        MSInix = mkHost "MSInix" "x86_64-linux";
      };
    };
}
