{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.python;
in {
  options.modules.dev.python.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [
      black
      ruff
      ruff-lsp
      isort
      python3
      pyright
      uv
    ];
  };
}
