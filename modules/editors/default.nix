{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacsNativeComp
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
    ];
  };

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
