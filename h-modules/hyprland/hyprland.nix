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
	  
		extraConfig = ''
			env = XDG_CURRENT_DESKTOP,Hyprland
			env = XDG_SESSION_DESKTOP,Hyprland
			env = XDG_SESSION_TYPE,wayland
			env = GDK_BACKEND,wayland
			env = QT_QPA_PLATFORM,wayland
			env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
			env = QT_AUTO_SCREEN_SCALE_FACTOR,1
			env = MOZ_ENABLE_WAYLAND,1
			env = GTK_USE_PORTAL,1
			
			exec-once = eval $(${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
			exec-once = export SSH_AUTH_SOCK
			exec-once = /run/current-system/sw/libexec/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
			exec-once = ${pkgs.kdePackages.plasma-integration}/bin/plasma-apply-colorscheme BreezeDark
			exec-once = ${pkgs.libsForQt5.qt5.qtwayland}/bin/qtwaylandscanner
			exec-once = caelestia shell -d
		'';
			# add it inside extra config to enable caelestia at the startup 
			# exec-once = caelestia shell -d

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "kitty"; 
			"$fileManager" = "thunar";
			"$menu" = "rofi -show drun";
			"$hyprlock" = "hyprlock --immediate";
			"$browser" = "firefox";

			env = [ 
				"HYPRCURSOR_THEME,catppuccin-mocha-lavender-cursors"
				"HYPRCURSOR_SIZE,25" 
				"XDG_CURRENT_DESKTOP,Hyprland"
				"XDG_SESSION_TYPE,wayland"
				"XDG_SESSION_DESKTOP,Hyprland"
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

			cursor = {
				no_hardware_cursors = true;
			};
			monitor=[
				",preferred,auto,1"
				#"HDMI-A-1,preferred@100,auto,1"
				#"eDP-1,disable"
			];
			misc = {
				force_default_wallpaper = 0;
			};
			device = {
				name = "asup1205:00-093a:2008-touchpad";
				enabled = false;
			};
			dwindle = {
				preserve_split = true;
			};

			decoration = {
				rounding = 7;  
			
				active_opacity = 1.0;  
				inactive_opacity = 1.0;  
			
				#drop_shadow = true;  
				#shadow_range = 4;  
				#shadow_render_power = 3;  
				#"col.shadow" = "rgba(7300ffee)";  
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
				"workspace special:third silent, class:^(obsidian)$"
				"float, class:(firefox|google-chrome|org.kde.okular|kitty)"
				"size 1800 1000, class:(org.kde.okular)"

				# Telegram
				"workspace special:fourth silent, class:(org.telegram.desktop|telegram-desktop|TelegramDesktop)"
				"size 1395 1380, class:(org.telegram.desktop|telegram-desktop|TelegramDesktop)"
				"move 135 35, class:(org.telegram.desktop|telegram-desktop|TelegramDesktop)"
				"float, class:(org.telegram.desktop|telegram-desktop|TelegramDesktop)"

				# Discord
				"workspace special:fourth silent, class:(discord)"
				"size 1600 800, class:(discord)"
				"move 1630 35, class:(discord)"
				"float, class:(discord)"
				#"opacity 0.90 0.90,class:^(obsidian)"
			];
			bind =
				[
					"$mod, R, exec, $terminal"
					"$mod, F, exec, $browser"
					"$mod+SHIFT, G, exec, $hyprlock"
					"$mod, G, global, caelestia:lock"
					"$mod, Q, killactive,"
					"$mod, M, exec, code --disable-gpu ~/.dotfiles/"
					# "$mod, T, exec, [workspace special:fourth silent] telegram-desktop & [workspace 1 silent] firefox & [workspace special:third silent] obsidian"
					# "$mod, T, exec, [workspace special:fourth silent] telegram-desktop"
					# "$mod, T, exec, [workspace 1 silent] firefox"
					# "$mod, T, exec, [workspace special:third silent] obsidian"
			#	"$mod, M, exit,"
					"$mod, E, exec, $fileManager"
					"$mod, V, togglefloating,"
					"$mod, D, exec, $menu"
					"$mod, Y, pseudo,"
					"$mod, J, togglesplit"
					"$mod, C, exec, code --disable-gpu"
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

					# Screenshot
					", Print, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" #| dunstify 'Screenshot of the region taken' -t 1000
					"SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" #| dunstify 'Screenshot of whole screen taken' -t 1000 # screenshot of the whole screen

					# Scratchpad
					"$mod, U, togglespecialworkspace, first"
					"$mod, I, togglespecialworkspace, second"
					"$mod, O, togglespecialworkspace, third"
					"$mod, P, togglespecialworkspace, fourth"
					"$mod, K, togglespecialworkspace, fifth"
					"$mod, L, togglespecialworkspace, sixth"
					"$mod SHIFT, U, movetoworkspace, special:first"
					"$mod SHIFT, I, movetoworkspace, special:second"
					"$mod SHIFT, O, movetoworkspace, special:third"
					"$mod SHIFT, P, movetoworkspace, special:fourth"
					"$mod SHIFT, K, movetoworkspace, special:fifth"
					"$mod SHIFT, L, movetoworkspace, special:sixth"

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
