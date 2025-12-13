{ config, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true; 
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];
  networking.firewall.enable = false;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.resolved.enable = true;
  environment.etc."systemd/resolved.conf".text = ''
    [Resolve]
    DNS=45.90.28.0#84d51a.dns.nextdns.io
    DNS=2a07:a8c0::#84d51a.dns.nextdns.io
    DNS=45.90.30.0#84d51a.dns.nextdns.io
    DNS=2a07:a8c1::#84d51a.dns.nextdns.io
    DNSOverTLS=yes
  '';

  networking.networkmanager.dns = "systemd-resolved";
}