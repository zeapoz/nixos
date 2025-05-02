{pkgs, ...}: {
  hm = {
    packages = with pkgs; [
      appimage-run
      bat
      bc
      fd
      fzf
      jaq
      jq
      killall
      lazygit
      p7zip
      ripgrep
      socat
      unzip
      wget
      yazi
      zip
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

      fastfetch.enable = true;
    };
  };
}
