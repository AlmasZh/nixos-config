{ config, pkgs, ...}:

{
	# virtualisation.waydroid.enable = true;

	virtualisation.virtualbox.host.enable = true;
	virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
	users.extraGroups.vboxusers.members = [ "almas" ];

	virtualisation.libvirtd = {
		enable = false;
		qemu.runAsRoot = false;
		allowedBridges = [
			"nm-bridge"
			"virbr0"
		];
	};
	programs.virt-manager.enable = true;
}
