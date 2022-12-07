{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  hm = {
    packages = with pkgs; [ brightnessctl ];
    programs.kitty.font.size = 14;
  };
}
