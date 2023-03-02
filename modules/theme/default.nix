{ inputs, config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.theme;
  nix-colors = inputs.nix-colors;
  colors = config.colorScheme.colors;
in
{
  imports = [ nix-colors.homeManagerModule ];

  options.modules.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
    colorScheme = import ./doom-one.nix;

    hm = {
      user = {
        programs.kitty.settings = with colors; {
          foreground = "#${fg}";
          background = "#${bg}";
          color0 = "#${black}";
          color1 = "#${red}";
          color2 = "#${green}";
          color3 = "#${yellow}";
          color4 = "#${blue}";
          color5 = "#${purple}";
          color6 = "#${cyan}";
          color7 = "#${white}";
          color8 = "#${lightBlack}";
          color9 = "#${lightRed}";
          color10 = "#${lightGreen}";
          color11 = "#${lightYellow}";
          color12 = "#${lightBlue}";
          color13 = "#${lightPurple}";
          color14 = "#${lightCyan}";
          color15 = "#${gray}";
        };

        home.pointerCursor = {
          name = "Bibata-Original-Classic";
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
            name = "Adwaita";
            package = pkgs.gnome.adwaita-icon-theme;
          };
          theme = {
            name = "adw-gtk3-dark";
            package = pkgs.adw-gtk3;
          };
        };
      };

      configFile."waybar/colors.css".text = with colors; ''
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
    };
  };
}

