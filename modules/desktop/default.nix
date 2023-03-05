{ config, lib, pkgs, ... }:

{
  imports = [ ./river ./hyprland ./applications ];

  hm = {
    packages = with pkgs; [
      anki
      discord
      helvum
      libreoffice
      pavucontrol
      playerctl
      pulseaudio
      signal-desktop
      slack
      swaylock-effects
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

    programs.swaylock.settings = {
      font = "Fira Sans";
      font-size = 24;
      indicator-idle-visible = true;
      show-keyboard-layout = true;
      # disable-caps-lock-text = true;
      # indicator-caps-lock = true;
      screenshots = true;
      clock = true;
      # grace = 10;
      indicator-radius = 100;
      indicator-thickness = 7;
      fade-in = 0.2;
      effect-blur = "7x5";
    };

    services.swayidle = {
      enable = true;
      extraArgs = [ "-w" ];
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
        { event = "lock"; command = "lock"; }
      ];
      timeouts = [{ timeout = 600; command = "${pkgs.swaylock}/bin/swaylock -f"; }];
    };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin ];
    };

    file-roller.enable = true;
  };

  xdg.portal.wlr.enable = true;

  # https://github.com/nix-community/home-manager/issues/1288
  security.pam.services.swaylock = { };
}
