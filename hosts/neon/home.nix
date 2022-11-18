{ config, lib, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home-manager.users.${config.user.name} = {
    home.packages = with pkgs; [ brightnessctl ];

    programs.kitty.font.size = 14;
  };
}
