{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
  wallpaper = ./wallpaper.jpg;
in {
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    hm = {
      packages = with pkgs; [
        brightnessctl
        grimblast
        hypridle
        hyprpaper
        pyprland
        wl-clipboard
      ];

      programs.hyprlock.enable = true;

      services = {
        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "hyprlock";
            };
            listener = [
              {
                timeout = 570;
                on-timeout = "brightnessctl -s set 1";
                on-resume = "brightnessctl -r";
              }
              {
                timeout = 600;
                on-timeout = "hyprlock";
              }
              {
                timeout = 900;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
              {
                timeout = 1200;
                on-timuout = "systemctl suspend";
              }
            ];
          };
        };
        swayosd = {
          enable = true;
        };
        swaync = {
          enable = true;
          settings = {
            widgets = ["title" "dnd" "notifications" "mpris"];
          };
        };
        hyprpaper = {
          enable = true;
          settings = {
            preload = "${wallpaper}";
            wallpaper = ",${wallpaper}";
          };
        };
      };

      configFile = {
        "hypr/hyprland.conf".source = config.lib.meta.mkMutableSymlink ./hyprland.conf;
        "hypr/hyprland-device-specifics.conf".text =
          if (config.networking.hostName == "helium")
          then ''            workspace=6,monitor:HDMI-A-2,default:true
                             monitor=HDMI-A-2,preferred,-1920x0,1''
          else "monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1";

        "hypr/hyprlock.conf".source = config.lib.meta.mkMutableSymlink ./hyprlock.conf;

        "hypr/pyprland.toml".source = config.lib.meta.mkMutableSymlink ./pyprland.toml;

        # Autostart Hyprland from tty1.
        "fish/conf.d/hyprland-uwsm.fish" = mkIf cfg.autostart {
          text = ''
            if string match -q "/dev/tty1" (tty)
                if uwsm check may-start -q
                    uwsm start hyprland-uwsm.desktop
                end
            end
          '';
          executable = true;
        };
      };
    };

    environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
