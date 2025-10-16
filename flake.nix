{
  description = "NixOS config + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url =  "github:nixos/nixpkgs/nixos-25.05";
    # nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # spicetify-nix = {
    #   url = "github:Gerg-L/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nur.url = "github:nix-community/NUR";

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
