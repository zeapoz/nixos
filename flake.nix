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
        overlays = [
          (final: prev: {
            waybar = prev.waybar.overrideAttrs (old: {
              mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
            });
          })
        ];
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        helium = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/helium/hardware-configuration.nix
            ./configuration.nix
            hyprland.nixosModules.default
            { networking.hostName = "helium"; }
          ];
        };

        neon = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/neon/hardware-configuration.nix
            ./configuration.nix
            { networking.hostName = "neon"; }
          ];
        };
      };

      homeConfigurations = {
        "jonathan@helium" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./hosts/helium/home.nix hyprland.homeManagerModules.default ];
        };

        "jonathan@neon" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./hosts/neon/home.nix hyprland.homeManagerModules.default ];
        };
      };
    };
}
