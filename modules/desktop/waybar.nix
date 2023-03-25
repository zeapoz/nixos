{ config, lib, ... }:
with lib;
let
  cfg = config.modules.desktop.waybar;
  configHome = config.home-manager.users.${config.user.name}.xdg.configHome;
in
{
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
          modules-left = [
            "clock"
            "cpu"
            "memory"
            "disk"
            (mkIf (cfg.mainDesktop == "hyprland") "wlr/workspaces")
            (mkIf (cfg.mainDesktop == "river") "river/tags")
          ];
          modules-center = [
            (mkIf (cfg.mainDesktop == "hyprland") "hyprland/window")
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
            "custom/power"
          ];

          "wlr/workspaces" = mkIf (cfg.mainDesktop == "hyprland") {
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            all-outputs = true;
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              "active" = "";
              "default" = "";
              "urgent" = "";
            };
            sort-by-number = true;
          };
          "river/tags" = mkIf (cfg.mainDesktop == "river") {
            num-tags = 4;
            tag-labels = [ "" "" "" "" ];
          };
          "hyprland/window" = {
            format = "{}";
            separate-outputs = true;
            max-length = 25;
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
          "custom/power" = {
            format = "";
            on-click = "wlogout";
          };
        };
      };

      style = ''
        @import "${configHome}/colors.css";

        * {
          border: none;
          border-radius: 0;
          font-family: "FiraCode", "Font Awesome 6 Free";
          font-weight: bold;
          font-size: 14px;
          min-height: 0px;
        }

        window#waybar {
          color: @fg;
          background: alpha(@bg, 0.9);
        }

        tooltip {
          background: @bg;
          border-radius: 10px;
          border-color: @fg;
          border-width: 2px;
          color: @fg;
        }

        #workspaces,
        #window,
        #cpu,
        #memory,
        #disk,
        #clock,
        #keyboard-state label.locked,
        #temperature,
        #custom-kernel,
        #network,
        #pulseaudio,
        #language,
        #battery,
        #tray,
        #custom-power {
          padding: 2px 10px;
          margin: 0 4px;
        }

        #workspaces button {
          color: alpha(@fg, 0.2);
          margin-bottom: 3px;
          padding: 2px 10px;
        }

        #workspaces button.active {
          color: @yellow-normal;
        }

        #workspaces button.urgent {
          color: @red-normal;
        }

        #cpu {
          color: @red-accent;
        }

        #memory {
          color: @green-accent;
        }

        #disk {
          color: @purple-normal;
        }

        #clock {
          color: @blue-accent;
        }

        #keyboard-state {
          color: @red-accent;
        }

        #temperature {
          color: @yellow-normal;
        }

        #temperature.critical {
          color: @red-normal;
        }

        #custom-kernel {
          color: @purple-normal;
        }

        #network {
          color: @blue-accent;
        }

        #network.ethernet {
          margin-bottom: 3px;
        }

        #pulseaudio {
          color: @red-accent;
        }

        #language {
          color: @green-accent;
        }

        #battery {
          color: @fg;
        }

        #battery.warning {
          color: @yellow-normal;
        }

        #battery.critical {
          color: @red-normal;
        }

        #custom-power {
          color: @purple-normal
        }
      '';
    };
  };
}
