{ config, pkgs, ... }:

{
	programs.hyprlock = {
		enable = true;

		settings = {
			general = {
				disable_loading_bar = true;
				grace = 4;
				hide_cursor = true;
				no_fade_in = false;
			};

			background = [
        {
          #monitor = "DP-2";
          blur_passes = 2;
          blur_size = 7;
          noise = 0.011700;
          path = "screenshot";
        }
      ];

      image = [
        {
          #monitor = "DP-2";
          halign = "center";
          path = "/home/almas/Pictures/profile.jpg";
          position = "0, 50";
          valign = "center";
        }
      ];

      input-field = [
				{
					size = "200,50";
					check_color = "rgb(30, 107, 204)";
					dots_center = true;
					dots_size = 0.200000;
					dots_spacing = 0.350000;
					fade_on_empty = false;
					font_color = "rgb(111, 45, 104)";
					halign = "center";
					hide_input = false;
					inner_color = "rgba(0, 0, 0, 0.2)";
					outer_color = "rgba(0, 0, 0, 0)";
					outline_thickness = 2;
					placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
					position = "0, -100";
					rounding = -1;
					valign = "center";
				} 
			];

      label = [
				{
					#monitor = "DP-2";
					text = "$TIME";
					color = "rgba(242, 243, 244, 0.75)";
					font_size = 95;
					font_family = "JetBrains Mono";
					position = "0, 300";
					halign = "center";
					valign = "center";
				}
        {
          #monitor = "DP-2";
          color = "rgba(242, 243, 244, 0.75)";
          font_family = "JetBrains Mono";
          font_size = 22; #95
          halign = "center";
          position = "0, 200"; # "0, 300"
					text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          #text = "cmd[update:1000] echo $(date + \"%A, %B %d\")"; #text = "$TIME";
          valign = "center";
        }
      ];

		};

	};
}
