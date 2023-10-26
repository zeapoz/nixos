{inputs}: [
  (_final: prev: {
    spotifyd = prev.spotifyd.override {withMpris = true;};

    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };
  })

  inputs.emacs-overlay.overlay
  inputs.neovim-nightly-overlay.overlay
]
