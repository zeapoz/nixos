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

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        helium = lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hosts/helium/hardware-configuration.nix
            ./configuration.nix
            ./modules
            home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              networking.hostName = "helium";
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
            ./modules
            home-manager.nixosModules.home-manager
            inputs.hyprland.nixosModules.default
            {
              imports = [ ./hosts/neon ];

              networking.hostName = "neon";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathan = import ./hosts/neon/home.nix;
            }
          ];
        };
      };
    };
}
