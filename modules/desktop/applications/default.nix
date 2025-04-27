{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  hm = {
    user.imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];

    packages = with pkgs; [
      anki
      aseprite
      bitwarden
      blender
      brave
      calibre
      discord
      firefox
      mullvad-vpn
      musescore
      obsidian
      pavucontrol
      playerctl
      pulseaudio
      qbittorrent
      signal-desktop-bin
      slack
      stremio
      telegram-desktop
      zathura
      zoom-us
      inputs.zen-browser.packages."${system}".twilight
    ];

    programs = {
      spicetify = {
        enable = true;
        theme = spicePkgs.themes.defaultDynamic;
      };
    };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin];
    };

    file-roller.enable = true;
  };
}
