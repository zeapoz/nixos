{ config, lib, pkgs, ... }:

{
  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    grim
    slurp
    swaybg
    wl-clipboard
  ];

  wayland.windowManager.hyprland.enable = true;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark-soft";
    font = "Fira Code 14";
    extraConfig = { show-icons = true; };
  };

  xdg.configFile = {
    "hypr" = {
      source = ./config/hypr;
      recursive = true;
    };

    # Autostart Hyprland from tty1.
    "fish/conf.d/hypr.fish" = {
      source = ./config/hypr.fish;
      executable = true;
    };
  };
}
