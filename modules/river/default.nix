{ config, lib, pkgs, ... }:

{
  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    grim
    river
    rivercarro
    slurp
    swaybg
    wl-clipboard
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark-soft";
    font = "Fira Code 14";
    extraConfig = { show-icons = true; };
  };

  xdg.configFile = {
    "river" = {
      source = ../../config/river;
      recursive = true;
    };

    # Autostart river from tty1.
    "fish/conf.d/river.fish" = {
      source = ../../config/fish/river.fish;
      executable = true;
    };
  };
}
