{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./desktop
      ./dev
      ./shell
      ./editors
      ./theme
      ./hardware
      ./options.nix
    ];
}
