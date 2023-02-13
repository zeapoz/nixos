{ config, lib, pkgs, ... }:

{
  imports = [ ./river ./hyprland ./applications ];

  hm = {
    packages = with pkgs; [
      anki
      discord
      # helvum
      libreoffice
      pavucontrol
      playerctl
      pulseaudio
      ranger
      signal-desktop
      slack
    ];

    programs.mako = {
      enable = true;
      anchor = "top-left";
      backgroundColor = "#FFFFFFFF";
      borderColor = "#A89984FF";
      borderRadius = 10;
      borderSize = 3;
      defaultTimeout = 5000;
      font = "Fira Sans";
      textColor = "#000000FF";
    };
  };

  xdg.portal.wlr.enable = true;
}
