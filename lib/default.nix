{ inputs, ... }:

inputs.nixpkgs.lib.extend (_final: prev: {
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

      specialArgs = { inherit inputs; };

      modules = [
        ../configuration.nix
        ../modules
        ../home.nix
        inputs.home-manager.nixosModules.home-manager
        {
          imports = [ ../hosts/${hostName} ];

          networking.hostName = "${hostName}";
        }
      ];
    };
})
