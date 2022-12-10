{ config, lib, pkgs, ... }:
with lib; {
  options.user.name = mkStrOpt "jonathan";
}
