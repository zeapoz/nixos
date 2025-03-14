{
  config,
  ...
}:

{
  programs = {
    neovim = {
      enable = true;
      withNodeJs = true;
    };

    fish.shellAliases.v = "nvim";
  };

  xdg.configFile."nvim".source = config.lib.meta.mkMutableSymlink ./.;
}
