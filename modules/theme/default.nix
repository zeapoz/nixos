{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (inputs) nix-colors;
  inherit (config.colorScheme) palette;
  cfg = config.modules.theme;
  theme = "kanagawa";
in {
  imports = [nix-colors.homeManagerModule];

  options.modules.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
    colorScheme = import ./${theme}.nix;

    hm = {
      user = {
        home.pointerCursor = {
          name = "Bibata-Original-Ice";
          package = pkgs.bibata-cursors;
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };

        gtk = {
          enable = true;
          font = {
            name = "Fira Sans";
            size = 12;
          };
          iconTheme = {
            name = "Kanagawa";
            package = pkgs.kanagawa-icon-theme;
          };
          theme = {
            name = "Kanagawa-BL";
            package = pkgs.kanagawa-gtk-theme;
          };
        };
      };

      configFile."colors.css".text = with palette; ''
        @define-color bg #${bg};
        @define-color fg #${fg};
        @define-color red-normal #${red};
        @define-color red-accent #${lightRed};
        @define-color green-normal #${green};
        @define-color green-accent #${lightGreen};
        @define-color yellow-normal #${yellow};
        @define-color yellow-accent #${lightYellow};
        @define-color blue-normal #${blue};
        @define-color blue-accent #${lightBlue};
        @define-color purple-normal #${purple};
        @define-color purple-accent #${lightPurple};
      '';

      configFile."colors.scss".text = with palette; ''
        $fg: #${fg};
        $bg: #${bg};
        $black: #${black};
        $red: #${red};
        $green: #${green};
        $yellow: #${yellow};
        $blue: #${blue};
        $purple: #${purple};
        $cyan: #${cyan};
        $white: #${white};
        $lightBlack: #${lightBlack};
        $lightRed: #${lightRed};
        $lightGreen: #${lightGreen};
        $lightYellow: #${lightYellow};
        $lightBlue: #${lightBlue};
        $lightPurple: #${lightPurple};
        $lightCyan: #${lightCyan};
        $gray: #${gray};
      '';
    };
  };
}
