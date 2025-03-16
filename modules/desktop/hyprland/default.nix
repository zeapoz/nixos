{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;

  configFile = import ./config.nix {inherit config pkgs;};
  inherit (configFile) hyprlandConfig;

  wallpaper = ./wallpaper.jpg;
in {
  imports = [../wlogout.nix];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      wlogout.enable = true;
    };

    programs.hyprland.enable = true;

    hm = {
      packages = with pkgs; [
        grim
        slurp
        wl-clipboard
        hyprpaper
        hyprsunset
      ];

      services = {
        swaync = {
          enable = true;
          settings = {
            widgets = [ "title" "dnd" "notifications" "mpris" ];
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
