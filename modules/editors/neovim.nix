{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
    disableGui = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hm = {
      packages = [ (mkIf (!cfg.disableGui) pkgs.neovide) ];

      programs.neovim = {
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
          (nvim-treesitter.withPlugins (plugins:
            with plugins; [
              nix
              lua
              rust
              zig
            ]))
          nvim-web-devicons
          onedark-nvim
          plenary-nvim
          project-nvim
          telescope-nvim
          toggleterm-nvim
          which-key-nvim
        ];
      };

      configFile."nvim" = {
        source = ../../config/nvim;
        recursive = true;
      };
    };
  };
}
