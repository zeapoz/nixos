{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.editors;
in
{
  options.editors = {
    neovim = {
      enable = mkEnableOption "neovim";
      disableGui = mkBoolOpt false;
    };
    emacs.enable = mkEnableOption "emacs";
  };

  config = {
    home-manager.users.jonathan = {
      home.packages = with pkgs; [
        (mkIf (cfg.emacs.enable) emacsNativeComp)
        (mkIf (cfg.neovim.enable) neovim-nightly)
        (mkIf (!cfg.neovim.disableGui) neovide)
      ];

      programs.neovim = mkIf cfg.neovim.enable {
        enable = true;
        package = pkgs.neovim-nightly;
        plugins = with pkgs.vimPlugins; [
          auto-pairs
          bufferline-nvim
          cmp-buffer
          cmp-cmdline
          cmp-nvim-lsp
          cmp-nvim-lsp-signature-help
          cmp-path
          cmp_luasnip
          comment-nvim
          dashboard-nvim
          friendly-snippets
          gitsigns-nvim
          gruvbox-material
          indent-blankline-nvim
          lspkind-nvim
          lualine-nvim
          luasnip
          neogit
          neo-tree-nvim
          nvim-cokeline
          nvim-cmp
          nvim-lspconfig
          nvim-surround
          (nvim-treesitter.withPlugins (plugins: with plugins; [
            tree-sitter-nix
            tree-sitter-lua
            tree-sitter-rust
            tree-sitter-zig
          ]))
          nvim-web-devicons
          plenary-nvim
          project-nvim
          telescope-nvim
          toggleterm-nvim
          which-key-nvim
        ];
      };

      xdg.configFile."nvim" = mkIf cfg.neovim.enable {
        source = ../../config/nvim;
        recursive = true;
      };
    };
  };
}
