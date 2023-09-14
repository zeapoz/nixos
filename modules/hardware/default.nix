{pkgs, ...}: {
  imports = [./bluetooth.nix ./keychron.nix];

  hm.packages = with pkgs; [kanata];

  # Fix disable while typing when using kanata.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [kanata]
    MatchUdevType=keyboard
    MatchName=kanata
    AttrKeyboardIntegration=internal
  '';
}
