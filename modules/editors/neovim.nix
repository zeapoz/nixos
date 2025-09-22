{
  config,
  pkgs,
  ...
}: let
  cfg = {
    configUrl = "https://github.com/zeapoz/nvim.git";
    configDir = config.hm.user.home.homeDirectory + "/.config/nvim";
  };
in {
  hm = {
    packages = [
      pkgs.tree-sitter
    ];

    programs = {
      neovim = {
        enable = true;
        withNodeJs = true;
      };

      fish.shellAliases.v = "nvim";
    };

    user.home.activation.nvimConfig = config.hm.user.lib.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${cfg.configDir}" ]; then
        run echo "Neovim config not found. Cloning ${cfg.configUrl}"
        run git clone --depth 1 ${cfg.configUrl} "${cfg.configDir}"
      else
        run echo "Neovim config already exits. Pulling latest changes from ${cfg.configUrl}"
        run git -C "${cfg.configDir}" pull
      fi
    '';
  };
}
