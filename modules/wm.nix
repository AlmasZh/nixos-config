{ config, pkgs, ... }:

{
	services.dbus = {
		enable = true;
		packages = [ pkgs.dconf ];
	};

	security = {
		pam.services.login.enableGnomeKeyring = true;
		pam.services.greetd.enableGnomeKeyring = true;
	};

	services.gnome.gnome-keyring.enable = true;
}
