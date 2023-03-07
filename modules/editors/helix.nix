{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.editors.helix;
in {
  options.modules.editors.helix.enable = mkEnableOption "helix";

  config = mkIf cfg.enable {
    hm.programs.helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor = {
          cursorline = true;
          cursor-shape.insert = "bar";
          completion-trigger-len = 1;
          idle-timeout = 0;
          shell = [ "fish" "-c" ];
        };
      };
    };
  };
}
