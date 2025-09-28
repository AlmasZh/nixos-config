{ config, ...}:


{
  security.sudo = {
    enable = true;
    extraConfig = ''
      almas ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/modprobe
    '';
  };
}

