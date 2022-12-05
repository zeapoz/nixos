{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.editors.emacs;
in
{
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";
    server.enable = mkEnableOption "emacs server";
    doom = rec {
      enable = mkEnableOption "doom";
      repo = mkStrOpt "https://github.com/doomemacs/doomemacs";
      configRepo = mkStrOpt "https://github.com/zeapoz/doom";
    };
  };

  config = mkIf cfg.enable {
    services.emacs = mkIf cfg.server.enable {
      enable = true;
      package = with pkgs; ((emacsPckagesFor emacsPgtkNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm ]));
    };

    home-manager.users.${config.user.name} = {
      home = {
        packages = with pkgs; [
          ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages
            (epkgs: [ epkgs.vterm ]))
          # Doom dependencies.
          (ripgrep.override { withPCRE2 = true; })
          fd
        ];

        sessionPath = mkIf cfg.doom.enable [ "$HOME/.emacs.d/bin" ];

        activation = mkIf cfg.doom.enable {
          installDoomEmacs = ''
            if [ ! -d "$HOME/.emacs.d" ]; then
               git clone --depth=1 "${cfg.doom.repo}" "$HOME/.emacs.d"
               git clone "${cfg.doom.configRepo}" "$HOME/.doom.d"
            fi
          '';
        };
      };
    };

    fonts.fonts = with pkgs; [
      emacs-all-the-icons-fonts
    ];
  };
}

