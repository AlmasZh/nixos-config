{ config, pkgs, ...}:

{
	# virtualisation.waydroid.enable = true;

	virtualisation.virtualbox.host.enable = false;
	virtualisation.virtualbox.guest.enable = false;
	virtualisation.virtualbox.guest.dragAndDrop = false;

	virtualisation.libvirtd = {
		enable = false;
		qemu.runAsRoot = false; # must be false
		allowedBridges = [
			"nm-bridge"
			"virbr0"
		];
	};

	programs.virt-manager.enable = false;
}
