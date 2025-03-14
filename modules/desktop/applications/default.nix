{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./browsers.nix
    ./gaming.nix
    ./media.nix
  ];

  hm = {
    user.imports = [inputs.anyrun.homeManagerModules.default];

    packages = with pkgs; [
      anki
      aseprite
      blender
      bitwarden
      discord
      mullvad-vpn
      pavucontrol
      playerctl
      pulseaudio
      signal-desktop
      telegram-desktop
      slack
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
          x = {fraction = 0.5;};
          y = {fraction = 0.3;};
          width = {fraction = 0.5;};
        };
        extraCss = ''
          .window {
            background-color: none;
          }
        '';
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
}
