{ config, lib, pkgs, ... }:
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
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde ]; 

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

  services.udisks2.enable = true;
	services.gvfs.enable = true;
	services.devmon.enable = true;

  security.rtkit.enable = true;
  
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
    packages = with pkgs; [ firefox ];
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
    platformTheme = "qt5ct";
    style = {
      package = pkgs.catppuccin-kvantum;
      name = "kvantum";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    tree
    curl
    git
		gh
    wget
    lshw
    btop
    htop
		fish
    unzip
    gzip
    zip
 		eza
		gnome-keyring
    cups
		openssl
		
    python312Packages.pip
    python312
		pipx
		gcc
		glibc
		gcc.libc
		glibc.dev
		libgcc
		zlib
		libjpeg
    go
    go-task
		gotools
    go-migrate
		nodejs_23

		fabric-ai
    ffmpeg
    jellyfin
    jellyfin-web
		obsidian

    devbox
		kubectl
		kubernetes
		minikube
		k9s
		grafana
		grafana-loki
		gitkraken
		ansible

    gawk
    procps
    tmux
		superfile
		jetbrains.pycharm-professional
    kitty
		gparted
		acpi

    wl-clipboard
    rofi-wayland
    hyprpaper
    hyprlock
    hyprcursor
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    arion
    dolphin
    kdePackages.qtwayland
    kdePackages.qtsvg
    docker-compose
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt5.qtwayland
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze.qt5
    kdePackages.breeze
    catppuccin-cursors 
    catppuccin-papirus-folders
    papirus-folders
  ];

  # system.copySystemConfiguration = true;
   environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
		JAVA_HOME = "/nix/var/nix/profiles/default/bin/java";
		#GOROOT = goroot;
		#GOPATH = "/home/almas/go";

    #WAYLAND_DISPLAY="wayland-1";
    #XDG_RUNTIME_DIR="/run/user/1000";
  }; 
	environment.sessionVariables.PATH = [ "$HOME/go/bin" ];
  system.stateVersion = "24.05";
}
