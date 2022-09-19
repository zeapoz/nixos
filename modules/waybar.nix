{ config, lib, pkgs, ... }:

{
  home-manager.users.jonathan = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          modules-left = [ "river/tags" "cpu" "memory" "disk" ];
          modules-center = [ "clock" ];
          modules-right = [
            "keyboard-state"
            "temperature"
            "custom/kernel"
            "network"
            "pulseaudio"
            "battery"
            "tray"
          ];

          "river/tags" = {
            num-tags = 4;
            tag-labels = [ "" "" "" "" ];
          };
          "clock" = {
            interval = 60;
            format = "{: %b %e %H:%M}";
            format-alt = "{: %a %d-%m-%y}";
          };
          "keyboard-state" = {
            capslock = true;
            format = "{icon}";
            format-icons = {
              locked = "CAPS";
              unlocked = "";
            };
          };
          "temperature" = {
            interval = 5;
            hwmon-path =
              "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon3/temp1_input";
            critical-threshold = 60;
            format = " {temperatureC}°C";
          };
          "network" = {
            format-wifi = " ({signalStrength}%)";
            format-ethernet = "";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "";
            format-alt = "{ipaddr}";
          };
          "custom/kernel" = {
            interval = "once";
            format = " {}";
            exec = "uname -r";
          };
          "disk" = {
            interval = 600;
            format = " {percentage_used}%";
            path = "/";
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
          "tray" = { spacing = 10; };
        };
      };
      style = ''
        @define-color bg #282828;
        @define-color bg1 #3c3836;
        @define-color fg #ebdbb2;
        @define-color red-normal #cc241d;
        @define-color red-accent #fb4934;
        @define-color green-normal #98971a;
        @define-color green-accent #b8bb26;
        @define-color yellow-normal #d79921;
        @define-color yellow-accent #fabd2f;
        @define-color blue-normal #458588;
        @define-color blue-accent #83a598;
        @define-color purple-normal #b16286;
        @define-color purple-accent #d3869b;
        @define-color orange-normal #d65d0e;
        @define-color orange-accent #fe8019;

        * {
          font-family: "FiraCode", "Font Awesome 6 Free";
          font-size: 14px;
          min-height: 0px;
        }

        window#waybar {
          background: rgba(28, 28, 28, 0.8);
          color: @fg;
        }

        #tags,
        #mode,
        #cpu,
        #memory,
        #disk,
        #clock,
        #keyboard-state label.locked,
        #temperature,
        #custom-kernel,
        #network,
        #pulseaudio,
        #battery,
        #tray {
          background: rgba(28, 28, 28, 0);
          padding: 2px 12px;
          margin: 0 4px;
          border-radius: 90px;
          font-weight: bold;
        }

        #tags button {
          color: @fg;
          border-radius: 0;
          border-bottom: 2px solid rgba(0, 0, 0, 0);
        }

        #tags button.focused {
          color: @yellow-normal;
          border-bottom: 2px solid @yellow-normal;
        }

        #tags button.active {
          background-color: @bg;
        }

        #tags button.urgent {
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

        #battery.warning {
          color: @yellow-normal;
        }

        #battery.critical {
          color: @red-normal;
        }
      '';
    };
  };
}
