{ config, lib, pkgs, ... }:

{
  # Cursor
  home.pointerCursor = {
    name = "catppuccin-mocha-lavender-cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    size = 24;
    gtk.enable = true;
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "blue" ];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "catppuccin-mocha-lavender-cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    # gtk4.extraConfig not needed
  };

  # QT
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum; # or qt6
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Blue
  '';

  # Environment
  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-blue-standard";
    XCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    XCURSOR_SIZE = "24";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";

    # Ensure icons/cursors are found
    XDG_DATA_DIRS = "${config.home.profileDirectory}/share:$XDG_DATA_DIRS";
  };

  # Install qt6ct
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    catppuccin-kvantum
  ];
}