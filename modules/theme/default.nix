{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.theme;
in
{
  options.modules.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
        size = 24;
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
          name = "Pop-dark";
          package = pkgs.pop-gtk-theme;
        };
      };
    };
  };
}
