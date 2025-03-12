{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shell;
in {
  options.modules.shell.enable = mkEnableOption "shell";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [
        bat
        fd
        fzf
        killall
        lazygit
        neofetch
        ripgrep
        unzip
        zip
        p7zip
        socat
        jq
        jaq
        bc
        yazi
        wget
      ];

      programs = {
        fish = {
          enable = true;
          shellAliases = {
            lg = "lazygit";
            cat = "bat --theme ansi";
            "..." = "cd ../..";
          };
          shellInit = ''
            set fish_greeting
            set -gx EDITOR nvim
            set -gx DIRENV_LOG_FORMAT ""
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

        zoxide.enable = true;

        eza = {
          enable = true;
          enableFishIntegration = true;
          extraOptions = ["--group-directories-first"];
          git = true;
          icons = "auto";
        };

        wezterm.enable = true;
      };
    };
  };
}
