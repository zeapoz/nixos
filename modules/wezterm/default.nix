{
  config,
  pkgs,
  ...
}: {
  hm = {
    packages = [pkgs.wezterm];
    configFile."wezterm".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
