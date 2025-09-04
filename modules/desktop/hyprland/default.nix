{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
  wallpaper = ./wallpaper.jpg;

  greetCmd = "${pkgs.tuigreet}/bin/tuigreet --time --remember exec uwsm start hyprland-uwsm.desktop";
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
      seahorse.enable = true;
    };

    services = {
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = greetCmd;
            user = "greeter";
          };
          default_session = initial_session;
        };
      };
      gnome.gnome-keyring.enable = true;
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

    hm = {
      packages = with pkgs; [
        kngw-shell
        brightnessctl
        gnome-keyring
        grimblast
        hypridle
        hyprls
        hyprpaper
        hyprpolkitagent
        libsecret
        pyprland
        seahorse
        wl-clipboard
        tuigreet
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
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };
        swayosd.enable = true;
        swaync = {
          enable = true;
          settings = {
            widgets = [
              "title"
              "dnd"
              "notifications"
              "mpris"
            ];
          };
        };
        hyprpaper = {
          enable = true;
          settings = {
            preload = "${wallpaper}";
            wallpaper = ",${wallpaper}";
          };
        };
        hyprpolkitagent.enable = true;
      };

      configFile = {
        "hypr/hyprland.conf".source = config.lib.meta.mkMutableSymlink ./hyprland.conf;
        "hypr/hyprland-device-specifics.conf".text =
          if (config.networking.hostName == "helium")
          then ''
            workspace=6,monitor:DP-2,default:true
                             workspace=5,monitor:DP-2,default:true
                             monitor=DP-1,2560x1440@164.80,0x0,auto
                             monitor=DP-2,1920x1080@60.00,auto-right,auto,transform,3''
          else "monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1";

        "hypr/hyprlock.conf".source = config.lib.meta.mkMutableSymlink ./hyprlock.conf;
        "hypr/pyprland.toml".source = config.lib.meta.mkMutableSymlink ./pyprland.toml;
        "hypr/scripts".source = config.lib.meta.mkMutableSymlink ./scripts;
      };
    };

    environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
