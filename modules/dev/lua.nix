{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.lua;
in {
  options.modules.dev.lua.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [
      lua-language-server
      stylua
    ];
  };
}
