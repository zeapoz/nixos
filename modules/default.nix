{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./dev
    ./editors
    ./theme
    ./media
    ./hardware
    ./options.nix
  ];
}
