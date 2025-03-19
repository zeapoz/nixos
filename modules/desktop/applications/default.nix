{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./gaming.nix
    ./media.nix
  ];

  hm.packages = with pkgs; [
    anki
    aseprite
    blender
    bitwarden
    discord
    mullvad-vpn
    pavucontrol
    playerctl
    pulseaudio
    signal-desktop
    telegram-desktop
    slack
  ];

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin];
    };

    file-roller.enable = true;
  };
}
