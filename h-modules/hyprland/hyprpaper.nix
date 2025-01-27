{ config, pkgs, ... }:

{
	services.hyprpaper = {
		enable = true;
		package = pkgs.hyprpaper;
		settings = {
			ipc = "off";
			splash = "false";
			#splash_offset = 2.0;

			preload = 
				[ "/share/wallpapers/nixos-wallpaper-catppuccin-mocha.png" ];
			wallpaper = 
				[ ",/share/wallpapers/nixos-wallpaper-catppuccin-mocha.png" ];
		};
	};
}
