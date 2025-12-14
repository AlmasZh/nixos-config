{ config, pkgs, unstablePkgs, ... }: 

{
  imports = [
    ./h-modules/list.nix
	];
  home = {
    username = "almas";
    homeDirectory = "/home/almas";
    stateVersion = "24.05";
  };

	programs.git = {
		enable = true;
    settings = {
      user = {
        email = "almas.zh22@gmail.com";
        name = "AlmasZh";
      };

			credential.helper = "store";
    };
	};

  nixpkgs.config.allowUnfree = true;

  home.packages = ( with pkgs; [
    # THUNAR
    xfce.thunar
    xfce.thunar-volman            # automount drives
    xfce.tumbler                  # thumbnail generation
    xfce.thunar-archive-plugin    # right-click extract/compress
    xfce.thunar-media-tags-plugin # audio tag view/edit
    xfce.catfish                  # search tool
    ffmpegthumbnailer
    file-roller
    sushi                         # Quick previewer for Nautilus

    # APPS
		google-chrome
    telegram-desktop discord
    libreoffice
    vlc mpv
		kdePackages.okular kdePackages.gwenview kdePackages.kimageformats
		qbittorrent
		obsidian

    # CLI TOOLS
    tt cliphist
		slurp grim
    neofetch cava starship
		libraw

    # DEVOPS
		awscli2 google-cloud-sdk
    tenv ansible gitkraken
    jetbrains-toolbox

    # DEV TOOLS
		gogetdoc air sqlc gnumake
    uv
		postman

    # DESKTOP
    meslo-lgs-nf
    noto-fonts nerd-fonts.iosevka nerd-fonts.hack nerd-fonts.go-mono nerd-fonts.caskaydia-mono
    catppuccin-cursors catppuccin-cursors.mochaLavender catppuccin-cursors.mochaMauve
  ]) ++ [
    unstablePkgs.antigravity
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/almas/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
