{pkgs, ...}: {
  imports = [
    ./gaming.nix
  ];

  hm.packages = with pkgs; [
    anki
    aseprite
    blender
    bitwarden
    discord
    mullvad-vpn
    obsidian
    pavucontrol
    playerctl
    pulseaudio
    signal-desktop-bin
    telegram-desktop
    slack
    zathura
    zoom-us
  ];

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin];
    };

    file-roller.enable = true;
  };
}
