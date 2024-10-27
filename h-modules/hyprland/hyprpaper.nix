{ config, pkgs, ... }:

{
	services.hyprpaper = {
		enable = true;
		package = pkgs.hyprpaper;
		settings = {
			ipc = "on";
			splash = "false";
			splash_offset = 2.0;

			preload = 
				[ "/share/wallpapers/backiee-283486-landscape.jpg" ];
			wallpaper = 
				[ ",/share/wallpapers/backiee-283486-landscape.jpg" ];
		};
	};
}
