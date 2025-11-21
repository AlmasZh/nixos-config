{
  services.xserver = {
    enable = true;
		xkb = { 
			layout = "us";
      variant = "";
      options = "caps:escape";
		};
    videoDrivers = [ "amdgpu" "nvidia" ];
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };
}