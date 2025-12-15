{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ipv6 = false;
      dns = [ "8.8.8.8" "1.1.1.1" ];
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    # arion
  ];
}