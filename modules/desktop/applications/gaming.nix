{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.applications.gaming;
in
{
  options.modules.desktop.applications.gaming.enable = mkEnableOption "gaming";

  config = mkIf cfg.enable {
    programs.steam.enable = true;

    hm.packages = with pkgs; [
      prismlauncher
    ];
  };
}
