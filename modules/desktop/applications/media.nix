{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.applications.media;
in {
  options.modules.desktop.applications.media = {
    enable = mkEnableOption "media";
    daw.enable = mkEnableOption "daw";
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs;
        [
          calibre
          freetube
          gimp
          helvum
          musescore
          spotify
          spotify-tui
        ]
        ++ optionals cfg.daw.enable [
          ardour
          drumgizmo
          guitarix
          sunvox
          synthv1
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
