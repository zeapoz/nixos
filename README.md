# NixOS

This repository houses my personal NixOS configuration. Keep in mind, this is very much an experiment to test out NixOS, so major changes and breakage are to be expected.

## Installation

This configuration is based on flakes. Thus, the command to rebuild NixOS with this configuration is:

``` fish
sudo nixos-rebuild switch --flakes .#
```

Alternatively, if you prefer to symlink the configuration to `/etc/nixos/flake.nix`, use this:

``` fish
sudo ln -s path/to/flake.nix /etc/nixos/flake.nix
sudo nixos-rebuild switch
```
