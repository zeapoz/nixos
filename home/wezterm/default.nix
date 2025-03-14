{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wezterm ];
  xdg.configFile."wezterm".source = config.lib.meta.mkMutableSymlink ./.;
}
