{
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./bluetooth.nix
    ./keychron.nix
    ./kanata
  ];

  options.hardware.hasBattery = mkBoolOpt false;
  config.environment.variables.HOST_HAS_BATTERY = boolToString config.hardware.hasBattery;
}
