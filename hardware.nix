{ config, ... }:

{
	hardware.enableAllFirmware = true;
	services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        "10-echo-cancel" = {
          "filter-chain" = {
            "nodes" = {
              "echo-cancel" = {
                "type" = "echo-cancel";
                "properties" = {
                  "aec.method" = "webrtc";
                  "aec.dump" = false;
                };
              };
            };
          };
        };
      };
    };
  };
  security.rtkit.enable = true;

  services.blueman.enable = true;
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
}