{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [
      nil
      deadnix
      statix
      alejandra
    ];
  };
}
