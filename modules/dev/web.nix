{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.web;
in {
  options.modules.dev.web.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs;
      [nodejs]
      ++ (with nodePackages; [
        prettier_d_slim
        vscode-langservers-extracted
        typescript
        typescript-language-server
        yarn
      ]);
  };
}
