{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.applications.browsers;
in
{
  options.modules.desktop.applications.browsers.enable = mkEnableOption "browsers";

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.librewolf = {
        enable = true;
        package = pkgs.librewolf-wayland;
      };

      programs.firefox.enable = true;
    };
  };
}
