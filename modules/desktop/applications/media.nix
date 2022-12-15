{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.applications.media;
in {
  options.modules.desktop.applications.media = {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        ardour
        calibre
        freetube
        gimp
        guitarix
        musescore
        spotify
        spotify-tui
        sunvox
      ];

      services.spotifyd = {
        enable = true;
        settings = {
          global = {
            username_cmd = "/home/${config.user.name}/secrets/spotifyd.user";
            password_cmd = "/home/${config.user.name}/secrets/spotifyd.pass";
            device_name = "${config.networking.hostName}";
          };
        };
      };
    };
  };
}
