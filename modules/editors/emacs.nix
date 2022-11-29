{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.editors;
in
{
  options.editors.emacs.enable = mkEnableOption "emacs";

  config = {
    home-manager.users.${config.user.name} = {
      home.packages = with pkgs; [
        (mkIf (cfg.emacs.enable) emacsPgtkNativeComp)
      ];
    };

    fonts.fonts = with pkgs; [
      emacs-all-the-icons-fonts
    ];
  };
}

