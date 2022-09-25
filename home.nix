{ config, lib, pkgs, ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    discord
    emacsNativeComp
    fd
    firefox
    freetube
    killall
    neofetch
    neovim-nightly
    nixfmt
    pavucontrol
    playerctl
    pulseaudio
    python3
    ripgrep
    rnix-lsp
    rust-analyzer
    rustup
    spotify-tui
    unzip
    zig
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
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Pop-dark";
      package = pkgs.pop-gtk-theme;
    };
    iconTheme = {
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
    font = {
      name = "Fira Sans";
      size = 12;
    };
  };

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        cat = "bat";

        ls = "exa -1 --group-directories-first --icons";
        la = "exa -1a --group-directories-first --icons";
        ll = "exa -la --group-directories-first --icons";
        lt = "exa -T --icons";

        v = "nvim";

        nix-rebuild = "z ~/.config/NixOS && sudo nixos-rebuild switch --flake .";
        nix-rehome = "z ~/.config/NixOS && home-manager switch --flake .";
        nix-fetch = "z ~/.config/NixOS && sudo nix flake update";
        nix-up = "nix-fetch && nix-rebuild && nix-rehome";
        nix-gc = "sudo nix-collect-garbage -d";
      };
      shellInit = ''
        set fish_greeting
        fish_add_path /home/jonathan/.emacs.d/bin
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

    git = {
      enable = true;
      userEmail = "zeapo@pm.me";
      userName = "zeapoz";
      extraConfig = {
        credential.helper = "store";
      };
      aliases = {
        a = "add";
        c = "commit";
        co = "checkout";
        f = "fetch";
        s = "status";
      };
      delta.enable = true;
    };

    exa.enable = true;
    zoxide.enable = true;
  };

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username_cmd = "/home/jonathan/secrets/spotifyd.user";
        password_cmd = "/home/jonathan/secrets/spotifyd.pass";
        device_name = "nixos";
      };
    };
  };
}
