{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
			#pkgs = import nixpkgs { system; config.allowUnfree = true; };
			unstablePkgs = import nixpkgs-unstable {
				inherit system;
				config.allowUnfree = true;
			};
		in {
		
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ 
				./configuration.nix
				{
					environment.systemPackages = with pkgs; [
						unstablePkgs.firefox
					];
				}
				];
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
