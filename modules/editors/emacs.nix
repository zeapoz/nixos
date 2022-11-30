{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.editors.emacs;
in
{
  options.modules.editors.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      home.packages = with pkgs; [
        emacsPgtkNativeComp
      ];
    };

    fonts.fonts = with pkgs; [
      emacs-all-the-icons-fonts
    ];
  };
}

