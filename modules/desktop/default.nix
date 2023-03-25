{ pkgs, ... }:

{
  imports = [ ./river ./hyprland ./applications ];

  hm = {
    packages = with pkgs; [
      anki
      discord
      helvum
      libreoffice
      mullvad-vpn
      pavucontrol
      playerctl
      pulseaudio
      signal-desktop
      slack
      swaylock-effects
      eww-wayland
    ];

    programs.swaylock.settings = {
      font = "Fira Sans";
      font-size = 24;
      indicator-idle-visible = true;
      show-keyboard-layout = true;
      screenshots = true;
      clock = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      fade-in = 0.2;
      effect-blur = "7x5";
    };

    services = {
      swayidle = {
        enable = true;
        extraArgs = [ "-w" ];
        events = [
          { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
          { event = "lock"; command = "lock"; }
        ];
        timeouts = [{ timeout = 600; command = "${pkgs.swaylock}/bin/swaylock -f"; }];
      };

      mako = {
        enable = true;
        anchor = "top-left";
        borderRadius = 10;
        borderSize = 3;
        defaultTimeout = 5000;
        font = "Fira Sans";
      };
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
