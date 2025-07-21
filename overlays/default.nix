{
  inputs,
  system,
}: [
  (_final: prev: {
    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };

    kngw-shell = inputs.kngw-shell.packages.${system}.default;
  })

  inputs.neovim-nightly-overlay.overlays.default
]
