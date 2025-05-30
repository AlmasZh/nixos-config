{ config, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
    #enableTCPIP = true;
		settings.listen_addresses = "localhost";
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      # ipv6
      host all all ::1/128      scram-sha-256
      # ipv4
      host all all 127.0.0.1/32 scram-sha-256
    '';
  };
}
