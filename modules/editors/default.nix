{lib, ...}:
with lib; {
  imports = [
    ./emacs.nix
    ./helix.nix
    ./neovim.nix
    ./vscode
  ];

  # TODO: deprecate, or find a use.
  options.modules.editors.mainEditor = mkStrOpt "";
}
