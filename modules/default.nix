{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./dev
    ./shell
    ./editors
    ./theme
    ./media
    ./hardware
    ./options.nix
  ];
}
