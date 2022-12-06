{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.dev;
in
{
  options.modules.dev = {
    enable = mkEnableOption "development";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      home.packages = with pkgs; [
        godot
        nixfmt
        python3
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
            st = "stash";
          };
          delta.enable = true;
        };

        exa.enable = true;
      };
    };
  };
}
