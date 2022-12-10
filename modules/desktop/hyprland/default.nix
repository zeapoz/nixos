{ config, lib, pkgs, inputs, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;

  configFile = import ./config.nix { inherit config lib; };
  hyprlandConfig = configFile.hyprlandConfig;
  autostartConfig = configFile.autostart;
in {
  imports = [ ../waybar.nix ];

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
    autostart = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      waybar.enable = true;
      wofi.enable = true;
    };

    hm = {
      user = {
        imports = [ inputs.hyprland.homeManagerModules.default ];
        wayland.windowManager.hyprland = {
          enable = true;
          extraConfig = hyprlandConfig;
        };
      };

      packages = with pkgs; [ grim slurp swaybg wl-clipboard ];

      configFile = {
        "hypr/autostart.sh" = {
          text = autostartConfig;
          executable = true;
        };

        # Autostart Hyprland from tty1.
        "fish/conf.d/hyprland.fish" = mkIf cfg.autostart {
          source = ../../../config/fish/hyprland.fish;
          executable = true;
        };
      };
    };
  };
}
