{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.desktop.hyprland;
in
{
  imports = [ ../waybar.nix ];

  options.desktop.hyprland = {
    enable = mkEnableOption "hyprland desktop";
    autostart = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;
    desktop.waybar.enable = true;

    home.packages = with pkgs; [
      grim
      slurp
      swaybg
      wofi
      wl-clipboard
    ];

    xdg.configFile = {
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
}
