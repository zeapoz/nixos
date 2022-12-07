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

  outputs = inputs@{ nixpkgs, ... }:
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

      lib = nixpkgs.lib.extend (final: prev: {
        mkOpt = type: default: prev.mkOption {
          inherit type default;
        };

        mkBoolOpt = default: prev.mkOption {
          inherit default;
          type = prev.types.bool;
        };

        mkStrOpt = default: prev.mkOption {
          inherit default;
          type = prev.types.str;
        };

        mkHost = hostname: lib.nixosSystem {
          inherit system pkgs lib;

          modules = [
            ./hosts/${hostname}/hardware-configuration.nix
            ./configuration.nix
            ./modules
            inputs.home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              imports = [
                ./hosts/${hostname}
                ./hosts/${hostname}/home.nix
              ];

              networking.hostName = "${hostname}";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      });
    in
    {
      nixosConfigurations = {
        helium = lib.mkHost "helium";
        neon = lib.mkHost "neon";
      };
    };
}
