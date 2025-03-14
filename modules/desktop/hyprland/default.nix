{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;

  configFile = import ./config.nix {inherit config pkgs;};
  inherit (configFile) hyprlandConfig;
  autostartConfig = configFile.autostart;
in {
  imports = [../wlogout.nix];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      wlogout.enable = true;
    };

    programs.hyprland.enable = true;

    hm = {
      packages = with pkgs; [
        grim
        slurp
        swaybg
        wl-clipboard
      ];

      configFile = {
        "hypr/hyprland.conf".text = hyprlandConfig;

        "hypr/autostart.sh" = {
          text = autostartConfig;
          executable = true;
        };

        # Autostart Hyprland from tty1.
        "fish/conf.d/hyprland.fish" = mkIf cfg.autostart {
          text = ''
            set TTY1 (tty)
            [ "$TTY1" = /dev/tty1 ] && exec Hyprland
          '';
          executable = true;
        };
      };
    };

    environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  };
}
