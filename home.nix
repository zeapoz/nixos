{ config, lib, pkgs, ... }:

{
  imports = [ ./modules/alacritty.nix ./modules/waybar.nix ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    brightnessctl
    discord
    emacs28NativeComp
    exa
    fd
    firefox
    freetube
    grim
    htop
    killall
    neofetch
    nixfmt
    nodePackages.npm
    pavucontrol
    pulseaudio
    python3
    ripgrep
    river
    rivercarro
    rnix-lsp
    rust-analyzer
    rustup
    slurp
    spotify-tui
    swaybg
    wl-clipboard
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

  programs.fish = {
    enable = true;
    shellAliases = { ls = "exa -1 --group-directories-first --icons"; };
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
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark-soft";
    font = "Fira Code 14";
    extraConfig = { show-icons = true; };
  };

  programs.zoxide.enable = true;

  xdg.configFile."river" = {
    source = ./config/river;
    recursive = true;
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
