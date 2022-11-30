{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.media;
in
{
  options.modules.media = {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      home.packages = with pkgs; [
        ardour
        freetube
        gimp
        guitarix
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
