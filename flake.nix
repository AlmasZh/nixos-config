{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
		home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, caelestia-shell, ... }:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			caelestia = import caelestia-shell;
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
					environment.systemPackages = [
						caelestia-shell.packages.${system}.default
					] ++ (with pkgs; [
						unstablePkgs.firefox
					]);
				}
				];
			};
		};
		
		homeConfigurations = {
			almas = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
					./home.nix
					caelestia-shell.homeManagerModules.default
					{
						programs.caelestia = {
							enable = true;
							systemd = {
								enable = false; # if you prefer starting from your compositor
								target = "graphical-session.target";
								environment = [];
							};
							settings = {
								bar.status = {
									showBattery = false;
								};
								paths.wallpaperDir = "~/Images";
							};
							cli = {
								enable = true; # Also add caelestia-cli to path
								settings = {
									theme.enableGtk = false;
								};
							};
						};
						home.packages = [
							#caelestia-shell.packages.${system}.default
						];
					}
				];
			};
		};

	};
}
