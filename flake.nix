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
    eww.url = "github:elkowar/eww";
    eww-scripts.url = "github:zeapoz/eww-scripts";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";

    overlays = import ./overlays {inherit inputs;};

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    lib = import ./lib {inherit inputs;};

    # TODO: Get from folder instead of manually.
    hosts = ["helium" "neon"];
  in {
    nixosConfigurations = with lib;
      mkHosts {
        inherit system pkgs lib hosts;
      };
  };
}
