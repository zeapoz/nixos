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
    prism-launcher.url = "github:PrismLauncher/PrismLauncher";
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
          inputs.prism-launcher.overlay
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

          modules = [ ./hosts/helium/home.nix inputs.hyprland.homeManagerModules.default ];
        };

        "jonathan@neon" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./hosts/neon/home.nix inputs.hyprland.homeManagerModules.default ];
        };
      };
    };
}
