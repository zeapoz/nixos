{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.applications.browsers;
in {
  options.modules.desktop.applications.browsers.enable =
    mkEnableOption "browsers";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        brave
        qutebrowser
        inputs.zen-browser.packages."${system}".twilight
      ];
    };
  };
}
