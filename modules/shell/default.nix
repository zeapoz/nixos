{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.shell;
in {
  options.modules.shell.enable = mkEnableOption "shell";

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    hm = {
      packages = with pkgs; [
        bat
        fd
        fzf
        killall
        neofetch
        ripgrep
        xdotool
        ranger
        unzip
        zip
        p7zip
      ];

      programs = {
        fish = {
          enable = true;
          shellAliases = {
            g = "git";
            gc = "git commit";
            gs = "git status";
            gpu = "git push";
            gp = "git pull";
            gf = "git fetch";

            v = if config.modules.editors.neovim.enable then "nvim" else "vim";
            cat = "bat --theme ansi";

            ls = "exa -1 --group-directories-first --icons";
            la = "exa -1a --group-directories-first --icons";
            ll = "exa -la --group-directories-first --icons";
            lt = "exa -T --group-directories-first --icons";

            nix-rebuild = " sudo nixos-rebuild switch --flake ~/.config/NixOS";
            nix-fetch = "sudo nix flake update ~/.config/NixOS";
            nix-up = "nix-fetch && nix-rebuild";
            nix-gc = "sudo nix-collect-garbage -d";

            "..." = "cd ../..";
          };
          shellInit = ''
            set fish_greeting
            ${if config.modules.editors.helix.enable then
              "set -gx EDITOR hx"
            else if config.modules.editors.neovim.enable then
              "set -gx EDITOR nvim"
            else
              "set -gx EDITOR vim"}
          '';
          plugins = with pkgs.fishPlugins; [
            {
              name = "tide";
              src = tide.src;
            }
            {
              name = "forgit";
              src = forgit.src;
            }
            {
              name = "pisces";
              src = pisces.src;
            }
            {
              name = "fzf-fish";
              src = fzf-fish.src;
            }
          ];
        };

        kitty = {
          enable = true;
          font.name = "FiraCode Nerd Font";
          settings = {
            background_opacity = "0.9";
            confirm_os_window_close = "0";
          };
        };

        zoxide.enable = true;
      };
    };
  };
}
