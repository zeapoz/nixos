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
          jnoortheen.nix-ide
          matklad.rust-analyzer
          pkief.material-icon-theme
          serayuzgur.crates
          tamasfe.even-better-toml
          vscodevim.vim
          asvetliakov.vscode-neovim
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
