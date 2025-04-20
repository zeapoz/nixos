{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix.enable = mkBoolOpt true;

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        nil
        deadnix
        statix
        alejandra
      ];

      programs = {
        fish = {
          enable = true;
          shellAliases = {
            nr = "sudo nixos-rebuild switch --flake ~/.config/NixOS";
            nf = "cd ~/.config/NixOS && git pull";
            nfu = "cd ~/.config/NixOS && nix flake update";
            nup = "nf && nr";
            ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
            nd = "nix develop -c fish";
            ndi = "nix develop --impure -c fish";
            ndp = "nix develop --pure-eval -c fish";
            ns = "nix-shell -p";
          };
        };
      };
    };
  };
}
