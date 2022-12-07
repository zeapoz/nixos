{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.editors.vscode;
in
{
  options.modules.editors.vscode = {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          vscodevim.vim
          jdinhlife.gruvbox
        ];
      };
    };
  };
}
