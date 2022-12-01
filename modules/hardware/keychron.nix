{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.hardware.keychron;
in
{
  options.modules.hardware.keychron.enable = mkEnableOption "keychron";

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name}.home.packages = with pkgs; [ vial ];

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
