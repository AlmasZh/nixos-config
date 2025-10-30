{ config, lib, pkgs, caelestia, ... }:
let
	goroot = "${pkgs.go}/share/go";
in {
  imports =
    [
      ./hardware-configuration.nix
			./modules/list.nix
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = false; 

      #menuentry 'Windows 11' --class windows --class os $menuentry_id_option 'osprober-efi-7823-188A' {
      extraEntries = ''
			menuentry 'Windows 11' --class windows --class os $menuentry_id_option 'custom-windows' {
				insmod part_gpt
				insmod fat
				search --no-floppy --fs-uuid --set=root 7823-188A
				chainloader /efi/Microsoft/Boot/bootmgfw.efi
						}
		 
						menuentry "Shutdown" {
							halt
			}

			menuentry "Reboot" {
							reboot
			}
     '';
    };
  };

	virtualisation.waydroid.enable = true;

	services.pulseaudio.enable = false; # make sure only pipewire runs
	hardware.enableAllFirmware = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true; 
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];
  networking.firewall.enable = false;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # TESTING
	#  programs.nix-ld.enable = true;

	#programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
 #];

  time.timeZone = "Asia/Almaty";

  xdg.portal.enable = true;
  xdg.portal.configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk pkgs.kdePackages.xdg-desktop-portal-kde ]; 

	virtualisation.virtualbox.host.enable = true;
	virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;

	users.extraGroups.vboxusers.members = [ "almas" ];

  # services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		wireplumber.enable = true;
  };

	#hardware.bluetooth.enable = true;
  services.blueman.enable = true;
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};

  services.flatpak.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.jellyfin.enable = false;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.udisks2.enable = true;
	services.gvfs.enable = true;
	services.devmon.enable = true;
  security.rtkit.enable = true;

  # Gnome
  services.gnome.core-apps.enable = true;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  
  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.hyprland.enable = true;
  programs.dconf.enable = true;
	programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.almas = {
    shell = pkgs.zsh; 
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "docker" "libvirtd" "qemu-libvirtd" "kvm" ];
    #packages = with pkgs; [ unstable.firefox ];
  };

  nix.settings.allowed-users = [ "@wheel" "almas"];

  users.users.nixosvmtest = {
    isSystemUser = true;
    initialPassword = "test";
    group = "nixosvmtest";
  };
  users.groups.nixosvmtest = {};

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct"; style = {
      package = pkgs.catppuccin-kvantum;
      name = "kvantum";
    };
  };
	
  
	environment.systemPackages = with pkgs; [
		# CLI TOOLS
    vim neovim tmux superfile
    git gh gitFull
    tree curl wget fish
    lshw
    btop htop
    unzip gzip zip
    eza
		gnome-keyring
    cups
		openssl
		gawk
    procps
		acpi
		waydroid
		
		# PROGRAMMING
    python312 python312Packages.pip python312Packages.virtualenv pipx
		gcc glibc gcc.libc glibc.dev libgcc gcc14
		zlib
		libjpeg
    go go-task gotools go-migrate
		nodejs_24
		ruby
		fabric-ai

		# MEDIA
    ffmpeg jellyfin jellyfin-web

		# DEVOPS
    devbox
		kubectl kubernetes minikube k9s
		terraform ansible vagrant
		grafana grafana-loki
		gitkraken
    docker-compose
    arion

		# APPS 
		jetbrains.pycharm-professional
    kitty
		gparted
		obsidian
		thunderbird
		genymotion

		# DESKTOP
    wl-clipboard
    rofi-wayland
    hyprpaper hyprlock hyprcursor
    xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-gtk
		kdePackages.dolphin kdePackages.qtwayland kdePackages.qtsvg
    qt6Packages.qtstyleplugin-kvantum qt6ct qt6.qtwayland
    kdePackages.breeze-gtk kdePackages.breeze-icons kdePackages.breeze
    catppuccin-cursors catppuccin-papirus-folders papirus-folders
		dejavu_fonts liberation_ttf
	];

  # system.copySystemConfiguration = true;
  # environment.sessionVariables = {
	# 	JAVA_HOME = "/nix/var/nix/profiles/default/bin/java";
	# 	#GOROOT = goroot;
	# 	#GOPATH = "/home/almas/go";

  #   #XDG_RUNTIME_DIR="/run/user/1000";
  # }; 
	environment.sessionVariables.PATH = [ "$HOME/go/bin" ];
  system.stateVersion = "24.05";
}
