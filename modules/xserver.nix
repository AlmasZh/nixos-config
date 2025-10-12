{
  services.xserver = {
    enable = true;
		xkb = { 
			layout = "us";
      variant = "";
      options = "caps:escape";
		};
    desktopManager.gnome.enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };
}
