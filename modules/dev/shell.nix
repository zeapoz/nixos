{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.dev.shell;
in {
  options.modules.dev.shell.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm.packages = with pkgs; [ shfmt ] ++ (with nodePackages; [
      nodePackages.bash-language-server
    ]);
  };
}
