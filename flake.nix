{
  description = "NixOS config + Home Manager";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # nixos modules
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak?ref=latest";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    # home-manager modules
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # flake.nix (outputs section)
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
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

          # Sops-nix module
          sops-nix.nixosModules.sops

          # Apply overlays to nixpkgs (if any)
          ({lib, ...}: {
            nixpkgs.overlays = builtins.attrValues overlays;
          })
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
