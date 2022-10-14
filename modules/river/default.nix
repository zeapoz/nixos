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
    wofi
  ];

  xdg.configFile = {
    "river" = {
      source = ../../config/river;
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

    # Autostart river from tty1.
    "fish/conf.d/river.fish" = {
      source = ../../config/fish/river.fish;
      executable = true;
    };
  };
}
