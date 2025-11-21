{ config, ... }:

{
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  
  services.power-profiles-daemon.enable = true;
  hardware.graphics = {
    enable = true;
  };


  hardware.nvidia = {
    prime = {
      amdgpuBusId = "PCI:54:0:0";
      nvidiaBusId = "PCI:1:0:0";

      offload.enable = true;
    };

    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
