{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
in
{
  imports = [ ../waybar.nix ];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.desktop.waybar.enable = true;
    programs.hyprland.enable = true;

    hm = {
      packages = with pkgs; [
        grim
        slurp
        swaybg
        wofi
        wl-clipboard
      ];

      configFile = {
        "hypr" = {
          source = ../../../config/hypr;
          recursive = true;
        };

        "wofi/style.css" = {
          source = ../../../config/wofi/style.css;
        };

        # Power menu script.
        "wofi/power-menu.sh" = {
          source = ../../../config/wofi/power-menu.sh;
          executable = true;
        };

        # Autostart Hyprland from tty1.
        "fish/conf.d/hyprland.fish" = mkIf cfg.autostart {
          source = ../../../config/fish/hyprland.fish;
          executable = true;
        };
      };
    };
  };
}
