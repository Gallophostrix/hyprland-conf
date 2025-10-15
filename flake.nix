{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.MSInix = nixpkgs.lib.nixosSystem {
      modules = [ ./configurations.nix ./home.nix];
    };
  };
}
