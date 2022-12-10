{ config, lib, pkgs, ... }:

{
  imports = [ ./river ./hyprland ./applications ];

  hm.packages = with pkgs; [
    anki
    discord
    helvum
    libreoffice
    pavucontrol
    playerctl
    pulseaudio
    ranger
    signal-desktop
  ];

  xdg.portal.wlr.enable = true;
}
