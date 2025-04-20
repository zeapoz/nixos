{inputs}: [
  (_final: prev: {
    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };
  })

  inputs.neovim-nightly-overlay.overlays.default
  inputs.eww.overlays.default
]
