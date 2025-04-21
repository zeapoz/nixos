{
  config,
  lib,
  ...
}:
with lib; {
  options.hardware.hasBattery = mkBoolOpt false;
  config.environment.variables.HOST_HAS_BATTERY = boolToString config.hardware.hasBattery;
}
