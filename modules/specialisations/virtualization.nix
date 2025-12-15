{ config, pkgs, ...}:

{

  specialisation = {
    vbox.configuration = {
      virtualisation.virtualbox.host.enable = true;
      # virtualisation.virtualbox.guest.enable = true;
      virtualisation.virtualbox.guest.dragAndDrop = true;
      users.extraGroups.vboxusers.members = [ "almas" ];
    };

    virt_m.configuration ={
      virtualisation.libvirtd = {
        enable = true;
        qemu.runAsRoot = false; # must be false
        allowedBridges = [ "virbr0" ];
      };

      programs.virt-manager.enable = true;
    };
  };

}
