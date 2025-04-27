{config, ...}: {
  hm = {
    programs.alacritty.enable = true;
    configFile."alacritty".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
