{config, ...}: {
  programs.helix.enable = true;
  xdg.configFile."helix".source = config.lib.meta.mkMutableSymlink ./.;
}
