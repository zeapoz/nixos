{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";
    server.enable = mkBoolOpt true;
    doom = {
      enable = mkEnableOption "doom";
      repo = mkStrOpt "https://github.com/doomemacs/doomemacs";
      configRepo = mkStrOpt "https://github.com/zeapoz/doom";
    };
  };

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        ((emacsPackagesFor emacs-pgtk).emacsWithPackages
          (epkgs: [epkgs.vterm]))
        # Doom dependencies.
        (ripgrep.override {withPCRE2 = true;})
        fd
      ];

      services.emacs = mkIf cfg.server.enable {
        enable = true;
        package = with pkgs; ((emacsPackagesFor emacsPgtk).emacsWithPackages
          (epkgs: [epkgs.vterm]));
      };

      user.home = {
        sessionPath = mkIf cfg.doom.enable ["$HOME/.emacs.d/bin"];

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

    fonts.packages = with pkgs; [emacs-all-the-icons-fonts];
  };
}
