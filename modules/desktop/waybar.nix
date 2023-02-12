{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.waybar;
in {
  options.modules.desktop.waybar = {
    enable = mkEnableOption "waybar";
    mainDesktop = mkStrOpt "";
    enableBatteryModule = mkBoolOpt false;
    temperaturePath = mkStrOpt "";
    keyboardPath = mkStrOpt "";
  };

  config = mkIf cfg.enable {
    hm.programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          modules-left = [ "clock" "cpu" "memory" "disk" ];
          modules-center = [
            (mkIf (cfg.mainDesktop == "hyprland") "wlr/workspaces")
            (mkIf (cfg.mainDesktop == "river") "river/tags")
          ];
          modules-right = [
            "keyboard-state"
            "temperature"
            "custom/kernel"
            "network"
            "pulseaudio"
            (mkIf (cfg.mainDesktop == "hyprland") "hyprland/language")
            (mkIf cfg.enableBatteryModule "battery")
            "tray"
          ];

          "wlr/workspaces" = mkIf (cfg.mainDesktop == "hyprland") {
            format = "{icon}";
            all-outputs = true;
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
            };
          };
          "river/tags" = mkIf (cfg.mainDesktop == "river") {
            num-tags = 4;
            tag-labels = [ "" "" "" "" ];
          };
          "cpu" = {
            interval = 10;
            format = " {usage}%";
            tooltip = false;
          };
          "memory" = {
            interval = 10;
            format = " {}%";
          };
          "disk" = {
            interval = 600;
            format = " {percentage_used}%";
            path = "/";
          };
          "clock" = {
            interval = 60;
            format = "{: %a %b %e %H:%M}";
          };
          "keyboard-state" = {
            capslock = true;
            format = "{icon}";
            format-icons = {
              locked = "CAPS";
              unlocked = "";
            };
            device-path = mkIf (cfg.keyboardPath != "") cfg.keyboardPath;
          };
          "temperature" = {
            interval = 5;
            critical-threshold = 60;
            format = " {temperatureC}°C";
            hwmon-path = mkIf (cfg.temperaturePath != "") cfg.temperaturePath;
          };
          "custom/kernel" = {
            interval = "once";
            format = " {}";
            exec = "uname -r";
          };
          "network" = {
            format-wifi = " {signalStrength}%";
            format-ethernet = "";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "";
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-muted = " {format_source}";
            format-source = "";
            format-source-muted = "";
            format-icons = { "default" = [ "" "" "" ]; };
            scroll-step = 1;
            tooltip-format = "{desc}; {volume}%";
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            on-click-middle = "pavucontrol";
          };
          "hyprland/language" = mkIf (cfg.mainDesktop == "hyprland") {
            "format-en" = " en";
            "format-sv" = " sv";
          };
          "battery" = mkIf cfg.enableBatteryModule {
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
          "tray" = { spacing = 10; };
        };
      };
      style = ../../config/waybar/style.css;
    };
  };
}
