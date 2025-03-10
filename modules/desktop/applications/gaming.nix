{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.applications.gaming;
in {
  options.modules.desktop.applications.gaming = {
    enable = mkEnableOption "gaming";
    enableStreaming = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;

    hm.packages = with pkgs; [
      prismlauncher
      tetrio-desktop
      wineWowPackages.wayland
    ];

    services.sunshine.enable = cfg.enableStreaming;

    networking.firewall = mkIf cfg.enableStreaming {
      enable = true;
      allowedTCPPorts = [47984 47989 47990 48010];
      allowedUDPPortRanges = [
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
  };
}
