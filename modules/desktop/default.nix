{
  pkgs,
  inputs,
  ...
}: {
  imports = [./river ./hyprland ./applications];

  hm = {
    user.imports = [inputs.anyrun.homeManagerModules.default];

    packages = with pkgs; [
      anki
      # bitwarden
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

    programs = {
      anyrun = {
        enable = true;
        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            symbols
            rink
            shell
          ];
        };
        extraCss = ''
          .window {
            background-color: none;
          }
        '';
      };

      swaylock = {
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
    };

    services.mako = {
      enable = true;
      anchor = "top-right";
      borderRadius = 10;
      borderSize = 2;
      margin = "4";
      padding = "8";
      width = 400;
      height = 150;
      defaultTimeout = 5000;
      layer = "overlay";
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

  # Hyprland enables its own portal.
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  #   xdgOpenUsePortal = true;
  # };

  # https://github.com/nix-community/home-manager/issues/1288
  security.pam.services.swaylock = {};
}
