{ config, pkgs, ...}:

{
	#virtualisation.vmware.host.enable = true;	
	virtualisation.waydroid.enable = true;

	virtualisation.virtualbox.host.enable = true;
	virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
	users.extraGroups.vboxusers.members = [ "almas" ];

	virtualisation.libvirtd = {
		enable = true;
		qemu.runAsRoot = false;
		allowedBridges = [
			"nm-bridge"
			"virbr0"
		];
	};
	programs.virt-manager.enable = true;
}
