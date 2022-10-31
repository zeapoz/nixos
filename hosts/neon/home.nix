{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ../../modules/desktops ];

  home.packages = with pkgs; [ brightnessctl ];

  desktops.river = {
    enable = true;
    autostart = true;
  };

  programs.kitty.font.size = 15;

  # Waybar settings.
  programs.waybar.settings.mainBar = {
    "temperature".hwmon-path =
      "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon3/temp1_input";
    "battery" = {
      interval = 60;
      states = {
        warning = 20;
        critical = 10;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-icons = [ "" "" "" "" ];
      format-alt = "{time} {icon}";
    };
  };
}
