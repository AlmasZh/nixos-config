# Theme for graphical apps
{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
    papirus-folders
  ];

  # Cursor setup
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Lavender-Cursors";
    #package = pkgs.catppuccin-cursors.mochaLavender;
    package = pkgs.catppuccin-cursors;
    #gtk.enable = true;
    size = 16;
  };

  # GTK Setup
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
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
      name = "Catppuccin-Mocha";
      #name = "Catppuccin-Mocha-Lavender-Cursors";
      #package = pkgs.catppuccin-cursors.mochaLavender;
      package = pkgs.catppuccin-cursors;
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
      gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
			icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
			cursor-theme = "Catppuccin-Mocha";
    };
  };

  xdg.configFile = {
    kvantum = {
      target = "Kvantum/kvantum.kvconfig";
      text = lib.generators.toINI { } {
        General.theme = "Catppuccin-Mocha-Blue";
      };
    };

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "Papirus-Dark";
					style = "kvantum";
        };
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
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
    };
  };

  systemd.user.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };
}
