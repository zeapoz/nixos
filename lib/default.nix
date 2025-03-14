{inputs, ...}:
inputs.nixpkgs.lib.extend (final: prev: {
  mkOpt = type: default: prev.mkOption {inherit type default;};

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

  mkHost = {
    hostName,
    system,
    pkgs,
    lib,
    ...
  }:
    prev.nixosSystem {
      inherit system pkgs lib;

      specialArgs = {inherit inputs;};

      modules = [
        ../hosts/${hostName}
        ../modules
        ../home
        inputs.home-manager.nixosModules.home-manager
        { networking.hostName = "${hostName}"; }
      ];
    };

  mkHosts = { hosts
  , system
  , pkgs
  , lib
  }: prev.attrsets.genAttrs hosts (name: final.mkHost {
    inherit system pkgs lib;

    hostName = name;
  });
})
