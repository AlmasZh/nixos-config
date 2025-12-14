{
  systemd.user.services.kanshi.Service.Restart = "always";
	services.kanshi = {
		enable = true;
		systemdTarget = "hyprland-session.target";

		settings =[
			{
				profile.name = "undocked";
				profile.outputs = [
					{
						criteria = "eDP-1";
						status = "enable";
					}
				];
			}
			{
				profile.name = "docked-dp2";
				profile.outputs = [
					{
						criteria = "DP-2";
						status = "enable";
						mode = "3440x1440@180.00Hz";
					}
					{
						criteria = "eDP-1";
						status = "disable";
					}
				];
			}
			{
				profile.name = "docked-hdmi";
				profile.outputs = [
					{
						criteria = "HDMI-A-1";
						status = "enable";
						mode = "3440x1440@100.00Hz";
					}
					{
						criteria = "eDP-1";
						status = "disable";
					}
				];
			}
		];
	
	};
}