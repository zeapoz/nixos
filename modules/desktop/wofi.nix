{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.wofi;
in {
  options.modules.desktop.wofi = {
    enable = mkEnableOption "wofi";
    power-menu.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [ wofi ];

      configFile = {
        "wofi/style.css" = { source = ../../config/wofi/style.css; };

        # Power menu script.
        "wofi/power-menu.sh" = mkIf cfg.power-menu.enable {
          source = ../../config/wofi/power-menu.sh;
          executable = true;
        };
      };
    };
  };
}
