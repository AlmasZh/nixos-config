{ config, pkgs, ...}:

{
	#virtualisation.vmware.host.enable = true;	
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
