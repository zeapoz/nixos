{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./dev
    ./editors
    ./theme
  ];
}
