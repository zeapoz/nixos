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
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin];
    };

    file-roller.enable = true;
  };
}
