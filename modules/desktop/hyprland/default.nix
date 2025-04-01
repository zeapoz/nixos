{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;

  configFile = import ./config.nix {inherit config pkgs blur_passes blur_size;};

  inherit (configFile) hyprlandConfig;

  wallpaper = ./wallpaper.jpg;

  blur_passes = 4;
  blur_size = 7;
in {
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    hm = {
      packages = with pkgs; [
        grim
        slurp
        wl-clipboard
        hyprpaper
        hyprsunset
        hypridle
        brightnessctl
      ];

      programs.hyprlock = {
        enable = true;
        settings = {
          label = [
            {
              text = "$TIME";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 95;
              font_family = "Fira Code";
              position = "0, 300";
              halign = "center";
              valign = "center";
            }
            {
              text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 22;
              font_family = "Fira Code";
              position = "0, 200";
              halign = "center";
              valign = "center";
            }
          ];
          background = [
            {
              inherit blur_passes blur_size;
              path = "${wallpaper}";
            }
          ];
          input-field = [
            {
              size = "300, 50";
              position = "0, -80";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(202, 211, 245)";
              inner_color = "rgb(91, 96, 120)";
              outer_color = "rgb(24, 25, 38)";
              outline_thickness = 5;
              placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
              shadow_passes = 2;
            }
          ];
        };
      };

      services = {
        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "hyprlock";
            };
            listener = [
              {
                timeout = 595;
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
        "hypr/hyprland.conf".text = hyprlandConfig;

        # Autostart Hyprland from tty1.
        "fish/conf.d/hyprland.fish" = mkIf cfg.autostart {
          text = ''
            set TTY1 (tty)
            [ "$TTY1" = /dev/tty1 ] && exec Hyprland
          '';
          executable = true;
        };
      };
    };

    environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
