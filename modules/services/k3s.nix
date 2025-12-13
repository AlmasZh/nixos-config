{config, pkgs, lib, ...}:
{
  services.k3s.enable = true;
  services.k3s.role = "server";

  systemd.services.k3s.wantedBy = lib.mkForce [];
  systemd.services.k3s.after = lib.mkForce [];
}