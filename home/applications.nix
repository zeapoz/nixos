{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackgaes.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home = {
    packages = with pkgs; [
      calibre
      musescore
      stremio
      qbittorrent
    ];

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.defaultDynamic;
    };
  };
}
