{ config, pkgs, ... }: 

{
  imports = [
    ./h-modules/list.nix
	];
  home.username = "almas";
  home.homeDirectory = "/home/almas";
  home.stateVersion = "24.05";

	programs.git = {
		enable = true;
		userName = "AlmasZh";
		userEmail = "almas.zh22@gmail.com";
		extraConfig = {
			credential.helper = "store";
		};
	};

  nixpkgs.config.allowUnfree = true;

  home.packages = ( with pkgs; [
    # APPS
		google-chrome
    telegram-desktop
    libreoffice
    vlc
    mpv
		kdePackages.okular
    kdePackages.dolphin
		kdePackages.gwenview
		kdePackages.kimageformats
    vscode
    spotify
		qbittorrent
		obsidian
		virt-manager
    postman

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

    # DEVOPS
		libvirt
		awscli2
		qemu

    # DEV TOOLS
		gogetdoc
		air
		sqlc
		gcc14

    # DESKTOP
    noto-fonts
		nerd-fonts.iosevka
		nerd-fonts.hack
		nerd-fonts.go-mono
		nerd-fonts.caskaydia-mono
    catppuccin-cursors
    catppuccin-cursors.mochaLavender
    catppuccin-cursors.mochaMauve
  ]);
	#++ ([
  # (pkgs.nerdfonts.override {
  #    fonts = [
  #      "Iosevka"
	#			"Hack"
	#			"Go-Mono"
	#			"CascadiaMono"
  #    ];
  #  })
  #]);

	programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
		initContent = ''
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
			l = "eza -la --icons --group-directories-first";
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
