{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    qt6ct
    catppuccin-cursors
    catppuccin-papirus-folders
    papirus-folders
  ];

  # Cursor setup
  home.pointerCursor = {
    name = "catppuccin-mocha-lavender-cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    size = 16;
    gtk.enable = true;
  };


  # GTK Setup
  gtk = {
    enable = true;
    theme = {
      # name = "Catppuccin-Mocha-Standard-Blue-Dark";
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "catppuccin-mocha-lavender-cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
    };
    gtk3 = {
      bookmarks = [
        "file:///home/almas/projects"
        "file:///home/almas/drive/Fotos"
        "file:///tmp"
      ];
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
    # GTK4 Setup
    "org/gnome/desktop/interface" = {
      # gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
      gtk-theme = "catppuccin-mocha-blue-standard";
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
      cursor-theme = "catppuccin-mocha-lavender-cursors";
    };
  };

  xdg.configFile = {
    kvantum = {
      target = "Kvantum/kvantum.kvconfig";
      text = lib.generators.toINI { } {
        # General.theme = "Catppuccin-Mocha-Blue";
        General.theme = "catppuccin-mocha-blue";
      };
    };
    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
          style = "kvantum";
        };
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "qt6ct";
      package = pkgs.qt6ct;
    };
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };

  systemd.user.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    XCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    XCURSOR_SIZE = "25";
    HYPRCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    HYPRCURSOR_SIZE = "25";
  };
}