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
      ryujinx
    ];

    services.sunshine = mkIf cfg.enableStreaming {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
