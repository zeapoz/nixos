{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev;
in {
  options.modules.dev.enable = mkEnableOption "development";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        codebook
        gemini-cli
        godot_4
        nodePackages.cspell
        zig
        zls
      ];

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        git = {
          enable = true;
          package = pkgs.gitFull;
          userEmail = "zeapo@pm.me";
          userName = "Jonathan Andersson";
          extraConfig = {
            credential.helper = "libsecret";
            init.defaultBranch = "main";
          };
          aliases = {
            a = "add";
            b = "branch";
            bi = "bisect";
            c = "commit";
            cl = "clone";
            co = "checkout";
            cp = "cherry-pick";
            d = "diff";
            f = "fetch";
            i = "init";
            l = "log";
            m = "merge";
            p = "pull";
            pu = "push";
            r = "reset";
            rb = "rebase";
            rs = "restore";
            s = "status";
            st = "stash";
            sw = "switch";
          };
          delta.enable = true;
        };
      };
    };
  };
}
