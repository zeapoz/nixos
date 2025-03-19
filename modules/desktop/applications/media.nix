{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.applications.media;
in {
  options.modules.desktop.applications.media = {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        calibre
        musescore
        spotify
        stremio
        qbittorrent
      ];
    };
  };
}
