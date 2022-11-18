{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.user;
in
{
  options.user.name = mkStrOpt "jonathan";
}
