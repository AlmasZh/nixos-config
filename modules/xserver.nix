{
  services.xserver = {
    enable = true;
		xkb = { 
			layout = "us";
      variant = "";
      options = "caps:escape";
		};
    videoDrivers = [ "amdgpu" ];
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };
}
