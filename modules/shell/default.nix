{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell;
in {
  imports = [./tmux.nix ./ranger.nix];

  options.modules.shell.enable = mkEnableOption "shell";

  config = mkIf cfg.enable {
    modules.shell.tmux.enable = false;
    programs.fish.enable = true;

    hm = {
      packages = with pkgs; [
        bat
        fd
        fzf
        killall
        lazygit
        neofetch
        ripgrep
        xdotool
        unzip
        zip
        p7zip
        socat
        jq
        jaq
        bc
        wget
      ];

      programs = {
        fish = {
          enable = true;
          shellAliases = {
            g = "git";
            gl = "git log";
            gap = "git add --patch";
            gc = "git commit";
            gs = "git status";
            gpu = "git push";
            gp = "git pull";
            gf = "git fetch";

            lg = "lazygit";

            cat = "bat --theme ansi";

            "..." = "cd ../..";
          };
          shellInit = ''
            set fish_greeting
            set -gx DIRENV_LOG_FORMAT ""
            ${
              if config.modules.editors.neovim.enable
              then "set -gx EDITOR nvim"
              else if config.modules.editors.helix.enable
              then "set -gx EDITOR hx"
              else "set -gx EDITOR vim"
            }
          '';
          plugins = with pkgs.fishPlugins; [
            {
              name = "forgit";
              inherit (forgit) src;
            }
            {
              name = "pisces";
              inherit (pisces) src;
            }
            {
              name = "fzf-fish";
              inherit (fzf-fish) src;
            }
          ];
        };

        starship.enable = true;

        kitty = {
          enable = true;
          font.name = "FiraCode Nerd Font";
          settings = {
            background_opacity = "0.9";
            confirm_os_window_close = "0";
          };
        };

        zoxide.enable = true;

        eza = {
          enable = true;
          enableFishIntegration = true;
          extraOptions = ["--group-directories-first"];
          git = true;
          icons = true;
        };

        wezterm.enable = true;

        alacritty.enable = true;
      };
    };
  };
}
