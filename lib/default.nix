{ inputs, ... }:

inputs.nixpkgs.lib.extend (final: prev: {
  mkOpt = type: default: prev.mkOption { inherit type default; };

  mkBoolOpt = default:
    prev.mkOption {
      inherit default;
      type = prev.types.bool;
    };

  mkStrOpt = default:
    prev.mkOption {
      inherit default;
      type = prev.types.str;
    };

  mkHost = { hostName, system, pkgs, lib, ... }:
    prev.nixosSystem {
      inherit system pkgs lib;

      modules = [
        ../modules
        ../home.nix
        ../configuration.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.hyprland.nixosModules.default
        {
          imports = [ ../hosts/${hostName} ];

          networking.hostName = "${hostName}";
        }
      ];
    };
})
