{ config, lib, pkgs, ... }:

{
  imports = [ ./bluetooth.nix ./keychron.nix ];
}
