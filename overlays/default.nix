{ inputs }:

[
  (final: prev: {
    spotifyd = prev.spotifyd.override { withMpris = true; };

    waybar = prev.waybar.overrideAttrs
      (old: { mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ]; });
  })

  inputs.emacs-overlay.overlay
  inputs.neovim-nightly-overlay.overlay
]
