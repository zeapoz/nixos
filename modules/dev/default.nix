{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dev;
in
{
  options.dev = {
    enable = mkEnableOption "development";
  };

  config = mkIf cfg.enable {
    home-manager.users.jonathan = {
      home.packages = with pkgs; [
        godot
        nixfmt
        rnix-lsp
        rust-analyzer
        rustup
        sumneko-lua-language-server
        zig
      ];

      programs = {
        git = {
          enable = true;
          userEmail = "zeapo@pm.me";
          userName = "zeapoz";
          extraConfig = {
            credential.helper = "store";
          };
          aliases = {
            a = "add";
            b = "branch";
            c = "commit";
            co = "checkout";
            d = "diff";
            f = "fetch";
            l = "log";
            p = "pull";
            pu = "push";
            r = "reset";
            re = "rebase";
            res = "restore";
            s = "status";
          };
          delta.enable = true;
        };

        exa.enable = true;
      };
    };
  };
}
