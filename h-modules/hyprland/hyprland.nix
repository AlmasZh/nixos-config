{ pkgs, lib, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; 

	wayland.windowManager.hyprland = {
		enable = true;
		systemd.variables = ["--all"];
		#package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		xwayland.enable = true;
	  

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "kitty"; 
			"$fileManager" = "dolphin";
			"$menu" = "rofi -show drun";
			"$browser" = "firefox";

			env = [ 
				#"XCURSOR_SIZE,24"
				"HYPRCURSOR_SIZE,25" 
				"XDG_CURRENT_DESKTOP,Hyprland"
				"XDG_SESSION_TYPE,wayland"
				"XDG_SESSION_DESKTOP,Hyprland"
				"XCURSOR_SIZE,36"
				"QT_QPA_PLATFORM,wayland"
				"XDG_SCREENSHOTS_DIR,~/screens"
			];

			input = {
				kb_layout = "us,kz";
				kb_variant = "";
				kb_model = "";
				kb_options = "grp:win_space_toggle";
				kb_rules = "";
		
				follow_mouse = 1;
		
				sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
			};

			monitor=",preferred,auto,1";

			decoration = {
				rounding = 7;  
			
				active_opacity = 1.0;  
				inactive_opacity = 1.0;  
			
				drop_shadow = true;  
				shadow_range = 4;  
				shadow_render_power = 3;  
				"col.shadow" = "rgba(7300ffee)";  
				#col.shadow = rgba(1a1a1aee)  
			
				# https://wiki.hyprland.org/Configuring/Variables/#blur  
				blur = {  
					enabled = false;
					size = 2;
					passes = 1;
					
					vibrancy = 0.1696;
				};
			};
			windowrulev2 = [
				"opacity 0.80 0.80,class:^(kitty|code)"
			];
			bind =
				[
					"$mod, R, exec, $terminal"
					"$mod, F, exec, $browser"
					"$mod, Q, killactive,"
					"$mod, M, exit,"
					"$mod, E, exec, $fileManager"
					"$mod, V, togglefloating,"
					"$mod, D, exec, $menu"
					"$mod, P, pseudo,"
					"$mod, J, togglesplit,"
					"$mod, C, exec, code"
					"$mod, RETURN, fullscreen"

					# Move focus with mod + arrow keys
					"$mod, left,  movefocus, l"
					"$mod, right, movefocus, r"
					"$mod, up,    movefocus, u"
					"$mod, down,  movefocus, d"

					# Move window
					"$mod SHIFT, left,  swapwindow, l"
					"$mod SHIFT, right, swapwindow, r"
					"$mod SHIFT, up,    swapwindow, u"
					"$mod SHIFT, down,  swapwindow, d"

					# Scratchpad
					"$mod, U, togglespecialworkspace, first"
					"$mod, I, togglespecialworkspace, second"
					"$mod, O, togglespecialworkspace, third"
					"$mod SHIFT, U, movetoworkspace, special:first"
					"$mod SHIFT, I, movetoworkspace, special:second"
					"$mod SHIFT, O, movetoworkspace, special:third"

					# Sound
					", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
					", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"

					", Print, exec, grimblast copy area"
				]
				++ (
					# binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
					builtins.concatLists (builtins.genList (i:
							let ws = i + 1;
							in [
								"$mod, code:1${toString i}, workspace, ${toString ws}"
								"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
							]
						)
						9)
			);
			bindm = 
			[
				# Move/resize windows with mod + LMB/RMB and dragging
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
			];
		};
	};
}