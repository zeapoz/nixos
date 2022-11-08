{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home.packages = with pkgs; [ brightnessctl ];

  programs.kitty.font.size = 14;
}
