{pkgs, ...}: {
  imports = [./river ./hyprland ./applications];

  hm = {
    packages = with pkgs; [
      anki
      bitwarden
      discord
      helvum
      libreoffice
      mullvad-vpn
      pavucontrol
      playerctl
      polkit_gnome
      pulseaudio
      signal-desktop
      slack
      xdg-utils
    ];

    programs.swaylock = {
      package = pkgs.swaylock-effects;
      settings = {
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
    };

    services.mako = {
      enable = true;
      anchor = "top-left";
      borderRadius = 10;
      borderSize = 3;
      defaultTimeout = 5000;
      font = "Fira Sans";
    };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin];
    };

    file-roller.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };

  # https://github.com/nix-community/home-manager/issues/1288
  security.pam.services.swaylock = {};
}
