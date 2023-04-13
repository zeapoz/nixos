{ inputs }:

[
  (final: prev: {
    spotifyd = prev.spotifyd.override { withMpris = true; };

    discord = prev.discord.override {
      nss = prev.nss_latest;
      withOpenASAR = true;
    };

    waybar = prev.waybar.overrideAttrs
      (old: {
        mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
        patches = [ ./hyprland-integration.patch ];
      });
  })

  inputs.emacs-overlay.overlay
  inputs.neovim-nightly-overlay.overlay
  inputs.kmonad.overlays.default
]
