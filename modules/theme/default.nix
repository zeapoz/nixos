{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.theme;
in {
  options.modules.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
    hm.user = {
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
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
        theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        };
      };
    };
  };
}
