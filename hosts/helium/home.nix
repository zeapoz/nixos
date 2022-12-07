{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  hm.programs.kitty.font.size = 12;
}
