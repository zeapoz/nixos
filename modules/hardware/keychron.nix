{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.hardware.keychron;
in
{
  options.hardware.keychron.enable = mkEnableOption "keychron";

  config = mkIf cfg.enable {
    home-manager.users.jonathan.home.packages = with pkgs; [ vial ];

    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "viaa";
        text = ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
        '';
        destination = "/etc/udev/rules.d/92-viia.rules";
      })
    ];
  };
}
