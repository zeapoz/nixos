{ config, lib, ... }:
with lib;
let cfg = config.modules.desktop.wlogout;
in {
  options.modules.desktop.wlogout.enable = mkEnableOption "wlogout";

  config = mkIf cfg.enable {
    hm.programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "sleep 1; swaylock -f";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "p";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "p";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Logout";
          keybind = "o";
        }
      ];
    };
  };
}
