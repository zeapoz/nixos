{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  programs.kitty.font.size = 12;
}
