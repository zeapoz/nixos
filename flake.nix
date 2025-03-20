{
  description = "My splendid NixOS configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    anyrun.url = "github:Kirottu/anyrun";
    eww.url = "github:elkowar/eww/revert-hot-reload-regression";
    eww-scripts.url = "github:zeapoz/eww-scripts";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";

    overlays = import ./overlays {inherit inputs;};

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    lib = import ./lib {inherit inputs;};

    hosts = ["helium" "neon"];
  in {
    nixosConfigurations = with lib;
      mkHosts {
        inherit system pkgs lib hosts;
      };
  };
}
