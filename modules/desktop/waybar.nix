{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.waybar;
  inherit (config.home-manager.users.${config.user.name}.xdg) configHome;
in {
  options.modules.desktop.waybar = {
    enable = mkEnableOption "waybar";
    mainDesktop = mkStrOpt "";
    temperaturePath = mkStrOpt "";
    keyboardPath = mkStrOpt "";
  };

  config = mkIf cfg.enable {
    hm.programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "left";
          modules-left = ["clock"];
          modules-center = [
            (mkIf (cfg.mainDesktop == "hyprland") "hyprland/workspaces")
            (mkIf (cfg.mainDesktop == "river") "river/tags")
          ];
          modules-right = [
            "network"
            "pulseaudio"
            (mkIf config.hardware.hasBattery "battery")
            "tray"
            "custom/power"
          ];

          "hyprland/workspaces" = mkIf (cfg.mainDesktop == "hyprland") {
            format = "{icon}";
            format-icons = {
              "1" = "一";
              "2" = "二";
              "3" = "三";
              "4" = "四";
              "5" = "五";
              "6" = "六";
            };
            persistent_workspaces = {
              "*" = 6;
            };
          };
          "clock" = {
            interval = 60;
            format = "   {:\n %H \n %M }";
          };
          "network" = {
            format-wifi = "\n{signalStrength}";
            format-ethernet = "";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "";
          };
          "pulseaudio" = {
            format = "{icon}\n{volume}\n{format_source}";
            format-muted = "\n{volume}\n{format_source}";
            format-source = "";
            format-source-muted = "";
            format-icons = {"default" = ["" "" ""];};
            scroll-step = 1;
            tooltip-format = "{desc}; {volume}%";
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            on-click-middle = "pavucontrol";
          };
          "battery" = mkIf config.hardware.hasBattery {
            interval = 60;
            states = {
              warning = 20;
              critical = 10;
            };
            format = "{icon}\n{capacity}";
            format-charging = "{capacity}";
            format-icons = ["" "" "" ""];
            format-alt = "{time} {icon}";
          };
          "tray" = {spacing = 10;};
          "custom/power" = {
            format = "";
            on-click = "wlogout -p layer-shell";
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
        }

        window#waybar {
          color: @fg;
          background: @bg;
        }

        tooltip {
          background: @bg;
          border-radius: 10px;
          border-color: @fg;
          border-width: 2px;
          color: @fg;
        }

        #clock,
        #workspaces,
        #network,
        #pulseaudio,
        #language,
        #battery,
        #tray,
        #custom-power {
          background: @bg;
          padding: 12px 2px;
          margin: 0 0;
        }

        #workspaces button {
          color: alpha(@fg, 0.2);
          padding: 2px 2px;
        }

        #workspaces button.persistent {
          color: alpha(@fg, 0.2);
        }

        #workspaces button.default {
          color: alpha(@red-normal, 0.5);
        }

        #workspaces button.active {
          color: @red-normal;
        }

        #clock {
          color: @blue-normal;
        }

        #custom-date {
          color: @purple-normal;
        }

        #network {
          color: @blue-normal;
        }

        #network.ethernet {
          padding-bottom: 5px;
        }

        #pulseaudio {
          color: @red-normal;
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
          color: @purple-normal;
        }
      '';
    };
  };
}
