{ config, lib, pkgs, ... }:

{
  imports = [ ./modules/alacritty.nix ./modules/river ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    discord
    emacs28NativeComp
    exa
    fd
    firefox
    freetube
    killall
    neofetch
    nixfmt
    nodePackages.npm
    pavucontrol
    pulseaudio
    python3
    ripgrep
    rnix-lsp
    rust-analyzer
    rustup
    spotify-tui
    zig
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

  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "exa -1 --group-directories-first --icons";
      tree = "exa -T";
      nix-rebuild = "z ~/.config/NixOS && sudo nixos-rebuild switch";
      nix-update =
        "z ~/.config/NixOS && sudo nix flake update && sudo nixos-rebuild switch";
      nix-clean = "sudo nix-collect-garbage -d";
    };
    shellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
    };
  };

  programs.git = {
    enable = true;
    userEmail = "zeapo@pm.me";
    userName = "zeapoz";
    extraConfig = { credential.helper = "store"; };
  };

  programs.zoxide.enable = true;

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
