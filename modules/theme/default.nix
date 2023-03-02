{ inputs, config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.theme;
  nix-colors = inputs.nix-colors;
in
{
  imports = [ nix-colors.homeManagerModule ];

  options.modules.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
    colorScheme = nix-colors.colorSchemes.nord;

    hm.user = {
      programs.kitty.settings = {
        foreground = "#${config.colorScheme.colors.base05}";
        background = "#${config.colorScheme.colors.base00}";
        color0 = "#${config.colorScheme.colors.base01}"; # Black
        color1 = "#${config.colorScheme.colors.base08}"; # Red
        color2 = "#${config.colorScheme.colors.base0B}"; # Green
        color3 = "#${config.colorScheme.colors.base0A}"; # Yellow
        color4 = "#${config.colorScheme.colors.base0D}"; # Blue
        color5 = "#${config.colorScheme.colors.base0E}"; # Magenta
        color6 = "#${config.colorScheme.colors.base0C}"; # Cyan
        color7 = "#${config.colorScheme.colors.base04}"; # White
        color8 = "#${config.colorScheme.colors.base01}"; # Black
        color9 = "#${config.colorScheme.colors.base08}"; # Red
        color10 = "#${config.colorScheme.colors.base0B}"; # Green
        color11 = "#${config.colorScheme.colors.base0A}"; # Yellow
        color12 = "#${config.colorScheme.colors.base0D}"; # Blue
        color13 = "#${config.colorScheme.colors.base0E}"; # Magenta
        color14 = "#${config.colorScheme.colors.base0C}"; # Cyan
        color15 = "#${config.colorScheme.colors.base04}"; # White
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
  };
}
