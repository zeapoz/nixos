{ config, lib, pkgs, ... }:
let
  mainDesktop = "hyprland";
in
{
  desktop = {
    ${mainDesktop} = {
      enable = true;
      autostart = true;
    };
    waybar = {
      mainDesktop = "${mainDesktop}";
      temperaturePath = "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon0/temp1_input";
      keyboardPath = "/dev/input/event3";
    };
  };

  editors = {
    neovim.enable = true;
    emacs.enable = true;
  };

  dev.enable = true;
  theme.enable = true;
  media.enable = true;
  hardware.keychron.enable = true;
}
