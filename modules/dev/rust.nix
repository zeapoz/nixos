{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.dev.rust;
in {
  options.modules.dev.rust.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [
      # rustup
      rust-analyzer
    ];
  };
}
