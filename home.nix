{ config, lib, pkgs, ... }:

{
  home-manager.users.${config.user.name} = {
    home = {
      username = "${config.user.name}";
      homeDirectory = "/home/${config.user.name}";

      # Packages that should be installed to the user profile.
      packages = with pkgs; [
        anki
        bat
        discord
        fd
        firefox
        helvum
        killall
        libreoffice
        librewolf-wayland
        neofetch
        pavucontrol
        playerctl
        prismlauncher
        pulseaudio
        python3
        python310Packages.ds4drv
        ranger
        ripgrep
        signal-desktop
        unzip
        xdotool
        zip
      ];

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "22.05";
    };

    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;

      fish = {
        enable = true;
        shellAliases = {
          g = "git";
          v = "nvim";
          cat = "bat";

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
          set -gx EDITOR nvim
          set fish_greeting

          fish_add_path /home/${config.user.name}/.emacs.d/bin
        '';
      };

      kitty = {
        enable = true;
        font = {
          name = "FiraCode Nerd Font";
        };
        settings = {
          background_opacity = "0.9";
          confirm_os_window_close = "0";
        };
        theme = "Gruvbox Dark";
      };

      starship = {
        enable = true;
        settings.add_newline = true;
      };

      zoxide.enable = true;
    };
  };
}
