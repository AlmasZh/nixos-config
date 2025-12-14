{ config, pkgs, unstablePkgs, ... }: 

{
  imports = [
    ./h-modules/list.nix
	];
  home.username = "almas";
  home.homeDirectory = "/home/almas";
  home.stateVersion = "24.05";

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

	systemd.user.services.kanshi.Service.Restart = "always";
	services.kanshi = {
		enable = true;
		systemdTarget = "hyprland-session.target";

		settings =[
			{
				profile.name = "undocked";
				profile.outputs = [
					{
						criteria = "eDP-1";
						status = "enable";
					}
				];
			}
			{
				profile.name = "docked-dp2";
				profile.outputs = [
					{
						criteria = "DP-2";
						status = "enable";
						mode = "3440x1440@180.00Hz";
					}
					{
						criteria = "eDP-1";
						status = "disable";
					}
				];
			}
			{
				profile.name = "docked-hdmi";
				profile.outputs = [
					{
						criteria = "HDMI-A-1";
						status = "enable";
						mode = "3440x1440@100.00Hz";
					}
					{
						criteria = "eDP-1";
						status = "disable";
					}
				];
			}
		];
	
	};

  nixpkgs.config.allowUnfree = true;

  home.packages = ( with pkgs; [
    # APPS
    xfce.thunar
    xfce.thunar-volman            # automount drives
    xfce.tumbler                  # thumbnail generation
    xfce.thunar-archive-plugin    # right-click extract/compress
    xfce.thunar-media-tags-plugin # audio tag view/edit
    xfce.catfish                  # search tool
    ffmpegthumbnailer
    file-roller
    gvfs                          # mount network drives (smb, sftp)
    sushi                         # Quick previewer for Nautilus
		google-chrome
    telegram-desktop discord
    libreoffice
    vlc mpv spotify
		kdePackages.okular kdePackages.gwenview kdePackages.kimageformats
    kdePackages.ffmpegthumbs kdePackages.kdegraphics-thumbnailers
		qbittorrent
		obsidian
		virt-manager postman

    # CLI TOOLS
    tt
    meslo-lgs-nf
		slurp
		grim
    neofetch
		cava
		gnumake
		libraw
		starship
    uv
    cliphist

    # DEVOPS
		libvirt
		awscli2 google-cloud-sdk
    tenv ansible gitkraken
    jetbrains-toolbox
		qemu

    # DEV TOOLS
		gogetdoc
		air
		sqlc
		gcc14

    # DESKTOP
    noto-fonts nerd-fonts.iosevka nerd-fonts.hack nerd-fonts.go-mono nerd-fonts.caskaydia-mono
    catppuccin-cursors catppuccin-cursors.mochaLavender catppuccin-cursors.mochaMauve

  ]) ++ [
    unstablePkgs.antigravity
  ];

	programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
		initContent = ''
			complete -C terraform terraform
      # export LD_LIBRARY_PATH="/nix/store/4gk773fqcsv4fh2rfkhs9bgfih86fdq8-gcc-13.3.0-lib/lib:$LD_LIBRARY_PATH"
    '';
    
    plugins = [
      #{
      #  name = "powerlevel10k-config";
      #  src = ./h-modules/p10k; 
      #  file = "p10k.zsh";
      #}
      #{
      #  name = "zsh-powerlevel10k";
      #  src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
      #  file = "powerlevel10k.zsh-theme";
      #}
      
    ];

    shellAliases = {
      c = "clear";
      dus = "du -sh ./";
      dusa = "du -sh ./*";
			l = "eza -la --icons --group-directories-first";
      icat = "kitty +kitten icat";
      ".." = "cd ..";
      "..." = "cd ../../";
			"gitlg" = "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

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
