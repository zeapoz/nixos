{ config, lib, pkgs, ... }:
let
  mainDesktop = "hyprland";
in
{
  modules = {
    desktop = {
      ${mainDesktop} = {
        enable = true;
        autostart = true;
      };
      waybar = {
        mainDesktop = "${mainDesktop}";
        temperaturePath = "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon1/temp1_input";
        keyboardPath = "/dev/input/event3";
      };
      applications = {
        browsers.enable = true;
        gaming.enable = true;
      };
    };

    editors = {
      emacs = {
        enable = true;
        doom.enable = true;
      };
      neovim.enable = true;
    };

    dev.enable = true;
    shell.enable = true;
    theme.enable = true;
    media.enable = true;
    hardware.keychron.enable = true;
  };
}
