{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.wofi;
  inherit (config.home-manager.users.${config.user.name}.xdg) configHome;
in
{
  options.modules.desktop.wofi = {
    enable = mkEnableOption "wofi";
    power-menu.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [ wofi ];

      configFile = {
        "wofi/style.css".text = ''
          @import "${configHome}/colors.css";

          window {
            margin: 5px;
            font-family: "Fira Sans";
            background-color: alpha(@bg, 0.9);
            border: 3px solid @fg;
            border-radius: 10px;
          }

          #input {
            margin: 5px;
            color: @fg;
            background-color: @bg;
            border: none;
          }

          #inner-box {
            margin: 5px;
            color: @fg;
            border: none;
          }

          #outer-box,
          #scroll,
          #text {
            margin: 5px;
          }

          #entry:selected {
            background-color: @bg;
          }

          #text:selected {
            color: @yellow-normal;
          }
        '';

        # Power menu script.
        "wofi/power-menu.sh" = mkIf cfg.power-menu.enable {
          source = ../../config/wofi/power-menu.sh;
          executable = true;
        };
      };
    };
  };
}
