{ config, lib, pkgs, ... }:

{
  # ── Cursor Theme ───────────────────────────────────────────────
  home.pointerCursor = {
    name    = "catppuccin-mocha-lavender-cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    size    = 24;
    gtk.enable = true;
  };

  # ── GTK Theme (for Thunar + all GTK apps) ─────────────────────
  gtk = {
    enable = true;
    theme = {
      name    = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name    = "catppuccin-mocha-lavender-cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

  };

  # ── Thumbnailing & Automount services ─────────────────────────
  # services.gvfs.enable = true;
  # services.tumbler.enable = true;

  # ── Thunar custom actions (e.g. “Open Terminal Here”) ─────────
  # xdg.configFile."Thunar/uca.xml".text = ''
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <actions>
  #     <action>
  #       <icon>utilities-terminal</icon>
  #       <name>Open Terminal Here</name>
  #       <command>kitty --working-directory %f</command>
  #       <description>Open a terminal in this directory</description>
  #       <patterns>*</patterns>
  #       <directories/>
  #     </action>
  #   </actions>
  # '';


  # QT Theme
  qt = {
    enable = true;
    platformTheme.name = "qtct"; # modern syntax
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };

  # ── Environment variables (Hyprland friendly) ─────────────────
  systemd.user.sessionVariables = {
    # GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark:dark";
    XCURSOR_THEME = "catppuccin-mocha-lavender-cursors";
    XCURSOR_SIZE = "24";
    QT_STYLE_OVERRIDE = "kvantum";
    # QT_QPA_PLATFORMTHEME = "qtct";
  };
}