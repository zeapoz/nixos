{inputs}: [
  (_final: prev: {
    spotifyd = prev.spotifyd.override {withMpris = true;};

    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };

    waybar = prev.waybar.overrideAttrs (old: rec {
      version = "b069537";
      src = prev.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = version;
        sha256 = "LFZ7Kzj9//vKtdOyDCjuT/VvANcnY009uooQwAd0sAQ=";
      };

      mesonFlags = old.mesonFlags ++ ["-Dexperimental=true" "-Dcava=disabled"];
      patches = [./hyprctl.patch];
    });
  })

  inputs.emacs-overlay.overlay
  inputs.neovim-nightly-overlay.overlay
]
