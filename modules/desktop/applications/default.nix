{ config, lib, pkgs, ... }:

{
  imports = [
    ./browsers.nix
    ./gaming.nix
    ./media.nix
  ];
}
