{ config, lib, pkgs, caelestia, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./hardware.nix
      ./network.nix
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
      default = "saved";

      extraEntriesBeforeNixOS = true;
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

  ### OS SPECIFIC
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Almaty";

  # TESTING
	#  programs.nix-ld.enable = true;

	#programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  #];

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # services.openssh.enable = true;

  services.flatpak.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.jellyfin.enable = false;

  services.udisks2.enable = true;
	services.gvfs.enable = true;
	services.devmon.enable = true;

  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.dconf.enable = true;
	programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.almas = {
    shell = pkgs.zsh; 
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "docker" "vboxusers" "libvirtd" "kvm" ];
  };

  nix.settings.allowed-users = [ "@wheel" "almas"];

	environment.systemPackages = with pkgs; [
		# CLI TOOLS
    vim neovim tmux superfile
    git gh gitFull
    tree curl wget fish
    btop htop acpi lshw # list hardware(lshw)
    unzip gzip zip
    eza
		gnome-keyring
		openssl
		gawk
    procps
    pavucontrol noisetorch

		# PROGRAMMING
    python312 python312Packages.pip python312Packages.virtualenv pipx
		glibc libgcc
		zlib
		libjpeg
    go go-task gotools go-migrate
		nodejs_24
		ruby

		# MEDIA
    ffmpeg

		# DEVOPS
    devbox
		kubectl kubernetes minikube k9s
		vagrant
		grafana grafana-loki
    lazygit

		# APPS 
    kitty
		gparted
		obsidian
		thunderbird

		# DESKTOP
    wl-clipboard
    brightnessctl
    rofi
    hyprpaper hyprlock hyprcursor
    xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-gtk

    # KDE & THEMING
		kdePackages.qtwayland kdePackages.qtsvg qt6Packages.qtstyleplugin-kvantum qt6.qtwayland
    kdePackages.breeze-gtk kdePackages.breeze-icons kdePackages.breeze
    kdePackages.plasma-integration
    catppuccin-cursors catppuccin-papirus-folders papirus-folders
		dejavu_fonts liberation_ttf
	];

  # system.copySystemConfiguration = true;
  # environment.sessionVariables = {
	# 	JAVA_HOME = "/nix/var/nix/profiles/default/bin/java";
	# 	#GOROOT = goroot;
	# 	#GOPATH = "/home/almas/go";
  # }; 
  # environment.variables.BRIGHTNESS_DEVICE = "amdgpu_bl1";
	environment.sessionVariables.PATH = [ "$HOME/go/bin" ];
  system.stateVersion = "24.05";
}
