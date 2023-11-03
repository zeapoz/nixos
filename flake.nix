{
  description = "My splendid NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    anyrun.url = "github:Kirottu/anyrun";
    eww-scripts.url = "github:zeapoz/eww-scripts";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";

    overlays = import ./overlays {inherit inputs;};

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    lib = import ./lib {inherit inputs;};
  in {
    nixosConfigurations = with lib; {
      helium = mkHost {
        hostName = "helium";
        inherit system pkgs lib;
      };

      neon = mkHost {
        hostName = "neon";
        inherit system pkgs lib;
      };
    };
  };
}
