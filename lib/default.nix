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
        inputs.home-manager.nixosModules.home-manager
        {config.networking.hostName = "${hostName}";}
        ../hosts/${hostName}
        ../modules
        ../theme
      ];
    };

  mkHosts = {
    hosts,
    system,
    pkgs,
    lib,
  }:
    prev.attrsets.genAttrs hosts (name:
      final.mkHost {
        inherit system pkgs lib;

        hostName = name;
      });
})
