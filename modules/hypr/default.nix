{ config, lib, pkgs, ... }:

{
  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    grim
    slurp
    swaybg
    wofi
    wl-clipboard
  ];

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr" = {
      source = ../../config/hypr;
      recursive = true;
    };

    "wofi/style.css" = {
      source = ../../config/wofi/style.css;
    };

    # Power menu script.
    "wofi/power-menu.sh" = {
      source = ../../config/wofi/power-menu.sh;
      executable = true;
    };

    # Autostart Hyprland from tty1.
    "fish/conf.d/hypr.fish" = {
      source = ../../config/fish/hypr.fish;
      executable = true;
    };
  };
}
