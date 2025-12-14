{
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

}