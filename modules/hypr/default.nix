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
      source = ./config/hypr;
      recursive = true;
    };

    "wofi" = {
      source = ./config/wofi;
      recursive = true;
    };

    # Autostart Hyprland from tty1.
    "fish/conf.d/hypr.fish" = {
      source = ./config/hypr.fish;
      executable = true;
    };
  };
}
