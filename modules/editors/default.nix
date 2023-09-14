{lib, ...}:
with lib; {
  imports = [
    ./emacs.nix
    ./helix.nix
    ./neovim.nix
    ./vscode
  ];

  options.modules.editors.mainEditor = mkStrOpt "";
}
