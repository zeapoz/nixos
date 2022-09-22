# NixOS

This repository houses my personal NixOS configuration. Keep in mind, this is very much an experiment to test out NixOS, so major changes and breakage are to be expected.

## Installation

This configuration is based on flakes. Thus, you have to specify a machine configuration after `--flakes`. Valid configurations are `.#helium` and `.#neon`. Therefore, the command to rebuild NixOS with this configuration is:

``` fish
cd path/to/directory
sudo nixos-rebuild switch --flakes .#machine
```

Alternatively, if you prefer to symlink the configuration to `/etc/nixos/flake.nix`, use this:

``` fish
sudo ln -s path/to/flake.nix /etc/nixos/flake.nix
sudo nixos-rebuild switch --flakes .#machine
```
