{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};
		
		homeConfigurations = {
			almas = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
			};
		};

	};
}
