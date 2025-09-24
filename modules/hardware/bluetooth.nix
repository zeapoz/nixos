{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth.enable = mkEnableOption "bluetooth";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    hm.packages = with pkgs; [overskride];
  };
}
