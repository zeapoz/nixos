{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.markdown;
in {
  options.modules.dev.markdown.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [
      markdownlint-cli
      marksman
    ];
  };
}
