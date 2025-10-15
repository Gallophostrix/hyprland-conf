{
  description = "NixOS config + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations.MSInix = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/msinix.nix
        
	home-manager.nixosModules.home-manager {
          # Flakes/CLI
          nix.settings.experimental-features = [
	    "nix-command"
	    "flakes"
	  ];

          # Home Mananager integration onto NixOS
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mik = import ./home/mik.nix;
        }
      ];
    };
  };
}
