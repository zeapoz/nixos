{
  description = "My splendid NixOS configuration.";

  inputs = {
    nixpks.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        helium = lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/helium/hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = import ./hosts/helium/home.nix;
            }
          ];
        };

        neon = lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/neon/hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = import ./hosts/neon/home.nix;
            }
          ];
        };
      };
    };
}
