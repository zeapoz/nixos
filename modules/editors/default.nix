{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacsNativeComp
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [
      auto-pairs
      dashboard-nvim
      gitsigns-nvim
      gruvbox-material
      lualine-nvim
      nvim-lspconfig
      nvim-tree-lua
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        tree-sitter-nix
        tree-sitter-rust
      ]))
      nvim-web-devicons
      telescope-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
