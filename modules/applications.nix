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
  };
}
