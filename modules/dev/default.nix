{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    godot
    nixfmt
    rnix-lsp
    rust-analyzer
    rustup
    sumneko-lua-language-server
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
}
