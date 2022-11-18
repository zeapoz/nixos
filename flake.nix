{
  description = "My splendid NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            spotifyd = prev.spotifyd.override {
              withMpris = true;
            };
            waybar = prev.waybar.overrideAttrs (old: {
              mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
            });
          })
          inputs.emacs-overlay.overlay
          inputs.neovim-nightly-overlay.overlay
        ];
      };

      lib = nixpkgs.lib.extend
        (final: prev: {
          mkBoolOpt = default: prev.mkOption {
            inherit default;
            type = prev.types.bool;
          };
          mkStrOpt = default: prev.mkOption {
            inherit default;
            type = prev.types.str;
          };
        });
    in
    {
      nixosConfigurations = {
        helium = lib.nixosSystem {
          inherit system pkgs lib;

          modules = [
            ./hosts/helium/hardware-configuration.nix
            ./configuration.nix
            ./modules
            home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              imports = [
                ./hosts/helium
                ./hosts/helium/home.nix
              ];

              networking.hostName = "helium";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

            }
          ];
        };

        neon = lib.nixosSystem {
          inherit system pkgs lib;

          modules = [
            ./hosts/neon/hardware-configuration.nix
            ./configuration.nix
            ./modules
            home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              imports = [
                ./hosts/neon
                ./hosts/neon/home.nix
              ];

              networking.hostName = "neon";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
