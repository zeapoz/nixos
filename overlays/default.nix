{inputs}: [
  (_final: prev: {
    spotifyd = prev.spotifyd.override {withMpris = true;};

    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };

    waybar = prev.waybar.overrideAttrs (old: rec {
      version = "9ef8faf";
      src = prev.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = version;
        sha256 = "N0j6Flph3RymFvoixcpmjQ4DwCdYX7P6zvEzz5Mxep8=";
      };

      mesonFlags = old.mesonFlags ++ ["-Dcava=disabled"];
    });
  })

  inputs.emacs-overlay.overlay
  inputs.neovim-nightly-overlay.overlay
  inputs.eww.overlays.default
]
