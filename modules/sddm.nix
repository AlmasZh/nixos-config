{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    theme = "elarun";
    settings = {
      Theme = {
        Current = "elarun";
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        FacesDir = "/run/current-system/sw/share/sddm/faces";
      };
    };
  };
  services.displayManager.defaultSession = "hyprland";
}
