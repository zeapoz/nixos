{lib, ...}:
with lib; {
  options = {
    user.name = mkStrOpt "jonathan";
    hardware.hasBattery = mkBoolOpt false;
  };
}
