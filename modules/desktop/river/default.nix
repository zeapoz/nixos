{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.river;
in {
  imports = [ ../waybar.nix ../wofi.nix ];

  options.modules.desktop.river = {
    enable = mkEnableOption "river";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      waybar.enable = true;
      wofi.enable = true;
    };

    hm = {
      packages = with pkgs; [ grim river rivercarro slurp swaybg wl-clipboard ];

      configFile = {
        "river" = {
          source = ../../../config/river;
          recursive = true;
        };

        # Autostart river from tty1.
        "fish/conf.d/river.fish" = mkIf cfg.autostart {
          source = ../../../config/fish/river.fish;
          executable = true;
        };
      };
    };
  };
}
