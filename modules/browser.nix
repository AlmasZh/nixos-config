{ config, pkgs, ... }:


{
	
	services.tor = {
		enable = true;
		openFirewall = true;
		relay = {
			enable = true;
			role = "relay";
		};
		settings = {
			ContactInfo = "toradmin@example.org";
			Nickname = "toradmin";
			ORPort = 9001;
			ControlPort = 9051;
			BandWidthRate = "1 MBytes";
		};
  };
}
