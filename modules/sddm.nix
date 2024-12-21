{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
		enableHidpi = true;
		package = pkgs.sddm;
  };

  #greetd = {
  #  enable = true;
  #  restart = false;
    #settings = {
      #default_session = {
        #command = ''
          #$(lib.makeBinPath [ pkgs.greetd.regreet ])
	#'';
      #};
    #};
  #};

  #programs.regreet.enable = true;
}
