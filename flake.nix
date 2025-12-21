{
  description = "NixOS config + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak?ref=latest";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    # thunderbird-catppuccin = {
    #   url = "github:catppuccin/thunderbird";
    #   flake = false;
    # };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # flake.nix (outputs section)
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  }: let
    inherit (nixpkgs.lib) genAttrs;

    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = genAttrs systems;
    pkgsFor = system: import nixpkgs {inherit system;};

    # Helper to create NixOS hosts
    mkHost = host: system: let
      hostVars = import ./hosts/${host}/variables.nix;
      overlays =
        if builtins.pathExists ./overlays
        then import ./overlays {inherit inputs host;}
        else [];
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self inputs host hostVars overlays;
        };
        modules = [
          # Host system configuration (system-only)
          ./hosts/${host}/configuration.nix

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager

          # Apply overlays to nixpkgs (if any)
          ({lib, ...}: {
            nixpkgs.overlays =
              (lib.optionals (builtins.isList overlays) overlays)
              ++ (lib.optionals (overlays ? additions) [overlays.additions])
              ++ (lib.optionals (overlays ? modifications) [overlays.modifications]);
          })

          # Glue to bind HM user and pass special args to HM
          {
            # Share pkgs between NixOS and HM
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Pass inputs/hostVars to HM modules too
            home-manager.extraSpecialArgs = {
              inherit self inputs host hostVars overlays;
            };

            home-manager.sharedModules = [
              inputs.noctalia.homeModules.default
            ];

            # Bind your Home-Manager root config (aggregates your HM modules)
            home-manager.users.${hostVars.username} = import ./hosts/${host}/home-config.nix;
          }
        ];
      };
  in {
    # Dev environment templates
    templates = import ./dev-shells;

    # Formatter per system
    formatter = forAllSystems (system: (pkgsFor system).alejandra);

    # NixOS host definitions
    nixosConfigurations = {
      MSInix = mkHost "MSInix" "x86_64-linux";
    };
  };
}
