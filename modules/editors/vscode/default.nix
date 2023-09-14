{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors.vscode;
in {
  options.modules.editors.vscode = {
    enable = mkEnableOption "vscode";
    configRepo = mkStrOpt "https://github.com/zeapoz/vscode";
  };

  config = mkIf cfg.enable {
    hm = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
          serayuzgur.crates
          mkhl.direnv
          usernamehw.errorlens
          tamasfe.even-better-toml
          pkief.material-icon-theme
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          gruntfuggly.todo-tree
          vscodevim.vim
        ];
      };

      user.home.activation = {
        installConfig = ''
          if [ ! -d "$HOME/.config/VSCodium/User" ]; then
             git clone "${cfg.configRepo}" "$HOME/.config/VSCodium/User"
          fi
        '';
      };
    };
  };
}
