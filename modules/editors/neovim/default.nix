{config, ...}: {
  hm = {
    programs = {
      neovim = {
        enable = true;
        withNodeJs = true;
      };

      neovide.enable = true;

      fish.shellAliases.v = "nvim";
    };

    configFile."nvim".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
