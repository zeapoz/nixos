{ config, lib, pkgs, ... }:

{
  imports = [
    ./river
    ./hyprland
    ./applications
  ];

  home-manager.users.${config.user.name} = {
    home.packages = with pkgs; [
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
  };

  xdg.portal.wlr.enable = true;
}
