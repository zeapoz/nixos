{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.applications.browsers;
in {
  options.modules.desktop.applications.browsers.enable =
    mkEnableOption "browsers";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [brave];

      programs.librewolf = {
        enable = true;
        package = pkgs.librewolf-wayland;
      };
    };
  };
}
