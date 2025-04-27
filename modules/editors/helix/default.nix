{config, ...}: {
  hm = {
    programs.helix.enable = true;
    configFile."helix".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
