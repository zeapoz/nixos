{config, ...}: {
  hm = {
    programs = {
      neovim = {
        enable = true;
        withNodeJs = true;
      };

      fish.shellAliases.v = "nvim";
    };

    configFile."nvim".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
