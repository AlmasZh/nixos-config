{ config, pkgs, ... }:

{
  services.dbus = {
		enable = true;
		packages = [ pkgs.dconf ];
	};
	services.xserver.desktopManager.gnome.enable = true;

	security = {
		pam.services.login.enableGnomeKeyring = true;
		pam.services.greetd.enableGnomeKeyring = true;
  };

  # Gnome
  services.gnome.core-apps.enable = true;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  services.gnome.gnome-keyring.enable = true;

}
