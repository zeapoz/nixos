{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
    disableGui = mkBoolOpt false;
    configRepo = mkStrOpt "https://github.com/zeapoz/nvim";
  };

  config = mkIf cfg.enable {
    hm = {
      packages = [ (mkIf (!cfg.disableGui) pkgs.neovide) ];

      programs.neovim = {
        enable = true;
        package = pkgs.neovim-nightly;
        # withNodeJs = true;
        # plugins = with pkgs.vimPlugins; [
        #   (nvim-treesitter.withPlugins (plugins:
        #     with plugins; [
        #       nix
        #       lua
        #       rust
        #       zig
        #       markdown
        #       markdown-inline
        #       yaml
        #       toml
        #       json
        #       bash
        #     ]))
        # ];
      };

      user.home.activation = {
        installNvimConfig = ''
          if [ ! -d "$HOME/.config/nvim" ]; then
             git clone "${cfg.configRepo}" "$HOME/.config/nvim"
          fi
        '';
      };
    };
  };
}
