{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell;
in {
  imports = [./tmux.nix];

  options.modules.shell.enable = mkEnableOption "shell";

  config = mkIf cfg.enable {
    modules.shell.tmux.enable = true;
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
        ranger
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

            r = "ranger";
            cat = "bat --theme ansi";

            t = "tmux";
            ta = "tmux attach";
            ts = "tmux list-sessions";
            tk = "tmux kill-session";

            nr = "sudo nixos-rebuild switch --flake ~/.config/NixOS";
            nf = "cd ~/.config/NixOS && git pull";
            nup = "nf && nr";
            ngc = "sudo nix-collect-garbage -d";
            nd = "nix develop -c fish";
            ndp = "nix develop --pure-eval -c fish";

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
              name = "tide";
              inherit (tide) src;
            }
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
          enableAliases = true;
          extraOptions = ["--group-directories-first"];
          git = true;
          icons = true;
        };

        wezterm = {
          enable = true;
          extraConfig = ''
            return {
              font = wezterm.font("FiraCode Nerd Font"),
              font_size = ${
              if (config.networking.hostName == "neon")
              then "14.0"
              else "12.0"
            },
              force_reverse_video_cursor = true,
              colors = {
                foreground = "#dcd7ba",
                background = "#1f1f28",

                cursor_bg = "#c8c093",
                cursor_fg = "#c8c093",
                cursor_border = "#c8c093",

                selection_fg = "#c8c093",
                selection_bg = "#2d4f67",

                scrollbar_thumb = "#16161d",
                split = "#16161d",

                ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
                brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
                indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
              },
              window_background_opacity = 0.7,
              hide_tab_bar_if_only_one_tab = true,
              window_close_confirmation = "NeverPrompt",
              window_padding = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0,
              },
              keys = {
                {
                  key = 'Enter',
                  mods = 'ALT',
                  action = wezterm.action.DisableDefaultAssignment,
                },
              },
            }
          '';
        };
      };
    };
  };
}
