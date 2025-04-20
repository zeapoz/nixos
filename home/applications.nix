{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    calibre
    musescore
    stremio
    qbittorrent
    brave
    inputs.zen-browser.packages."${system}".twilight
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.defaultDynamic;
  };
}
