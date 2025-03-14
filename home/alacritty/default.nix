{ config, ... }:

{
  programs.alacritty.enable = true;
  xdg.configFile."alacritty".source = config.lib.meta.mkMutableSymlink ./.;
}
