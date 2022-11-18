{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home-manager.users.${config.user.name}.programs.kitty.font.size = 12;
}
