{
  description = "My splendid NixOS configuration.";

  inputs = {
    nixpks.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, ... }:
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
          inherit system pkgs;

          modules = [
            ./hosts/helium/hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            hyprland.nixosModules.default
            {
              programs.hyprland.enable = true;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = import ./hosts/helium/home.nix;
            }
          ];
        };

        neon = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/neon/hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            hyprland.nixosModules.default
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
