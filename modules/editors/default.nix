{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
    ./emacs.nix
    ./neovim.nix
    ./vscode
  ];

  options.modules.editors.mainEditor = mkStrOpt "";
}
