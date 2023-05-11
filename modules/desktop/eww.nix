{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.desktop.eww;
in
{
  options.modules.desktop.eww.enable = mkEnableOption "eww";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        eww-wayland
        jaq
        jc
      ];

      configFile = {
        "NixOS/config/eww/modules/battery.yuck".text =
          if config.hardware.hasBattery then ''
            (deflisten battery "scripts/battery")
            (defwidget battery []
              (box :class "module battery ''${battery.class}"
                   :orientation "v"
                (label :class "icon" :text "''$''${battery.icon}")))''
          else ''
            (defwidget battery []
              (box :visible false))'';

        "NixOS/config/eww/modules/bar2.yuck".text =
          if (config.networking.hostName == "helium") then ''
            (defwindow bar2
              :monitor 1
              :geometry (geometry 
                :x "0"
                :x "0"
                :width "2%"
                :height "100%";
                :anchor "center right")
              :stacking "fg"
              :exclusive true
              (bar-box))''
          else "";
      };
    };
  };
}
