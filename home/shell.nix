{pkgs, ...}: {
  home.packages = with pkgs; [
    appimage-run
    bat
    fd
    fzf
    killall
    lazygit
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
    starship.enable = true;
    zoxide.enable = true;

    fish = {
      enable = true;
      shellAliases = {
        lg = "lazygit";
        cat = "bat --theme ansi";
        ff = "fastfetch";
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

    eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = ["--group-directories-first"];
      git = true;
      icons = "auto";
    };

    fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "builtin";
          height = 15;
          width = 30;
          padding = {
            top = 5;
            left = 3;
          };
        };
        modules = [
          "break"
          {
            type = "custom";
            format = "┌──────────────────────Hardware──────────────────────┐";
            outputColor = "90";
          }
          {
            type = "host";
            key = " PC";
            keyColor = "green";
          }
          {
            type = "cpu";
            key = "│ ├";
            keyColor = "green";
          }
          {
            type = "gpu";
            key = "│ ├";
            keyColor = "green";
          }
          {
            type = "memory";
            key = "│ ├";
            keyColor = "green";
          }
          {
            type = "disk";
            key = "└ └󰨣";
            keyColor = "green";
          }
          {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
            outputColor = "90";
          }
          "break"
          {
            type = "custom";
            format = "┌──────────────────────Software──────────────────────┐";
            outputColor = "90";
          }
          {
            type = "os";
            key = " OS";
            keyColor = "yellow";
          }
          {
            type = "kernel";
            key = "│ ├󰌽";
            keyColor = "yellow";
          }
          {
            type = "bios";
            key = "│ ├";
            keyColor = "yellow";
          }
          {
            type = "packages";
            key = "│ ├󰏓";
            keyColor = "yellow";
          }
          {
            type = "shell";
            key = "└ └";
            keyColor = "yellow";
          }
          "break"
          {
            type = "wm";
            key = " DE";
            keyColor = "blue";
          }
          {
            type = "lm";
            key = "│ ├󰍂";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = "│ ├󰉼";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = "└ └";
            keyColor = "blue";
          }
          {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
            outputColor = "90";
          }
          "break"
          {
            type = "custom";
            format = "┌─────────────────Uptime / Age / DT─/────────────────┐";
            outputColor = "90";
          }
          {
            type = "command";
            key = "  OS Age ";
            keyColor = "magenta";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            type = "uptime";
            key = "  Uptime ";
            keyColor = "magenta";
          }
          {
            type = "datetime";
            key = "  DateTime ";
            keyColor = "magenta";
          }
          {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
            outputColor = "90";
          }
          "break"
          "colors"
        ];
      };
    };
  };
}
