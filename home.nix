{ config, pkgs, ... }: 

{
  imports = [
    ./h-modules/hyprland/hyprland.nix
    ./h-modules/hyprland/hyprpaper.nix
		./h-modules/programs/waybar.nix
    ./h-modules/themes/wm-themes.nix    
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
    telegram-desktop
    libreoffice
    vlc
    mpv
    tt
    zsh-powerlevel10k
    meslo-lgs-nf
    noto-fonts
    dolphin
    vscode
    nodejs_22
		slurp
		grim
    neofetch
    spotify
    postman
		cava
		gnumake
		qbittorrent
		air
		kdePackages.gwenview
		kdePackages.kimageformats
		libraw
		starship
		gogetdoc
		libvirt
		virt-manager
		qemu
		obsidian

  ]) ++ ([
   (pkgs.nerdfonts.override {
      fonts = [
        "Iosevka"
				"Hack"
				"Go-Mono"
				"CascadiaMono"
      ];
    })
  ]);

	programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
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
