{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home.packages = with pkgs; [ brightnessctl ];

  desktop = {
    river = {
      enable = true;
      autostart = true;
    };
    waybar = {
      temperaturePath = "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon0/temp1_input";
    };
  };

  dev.enable = true;
  theme.enable = true;
  editors.neovim.enable = true;

  programs.kitty.font.size = 14;
}
