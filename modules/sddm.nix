{ config, pkgs, ... }:

{
  #services.displayManager.sddm = {
    #enable = true;
    #wayland.enable = true;
		#enableHidpi = true;
		#package = pkgs.sddm;
  #};

	services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "almas";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
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
