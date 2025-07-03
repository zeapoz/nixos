{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.kanata;
in {
  options.modules.hardware.kanata.enable = mkEnableOption "kanata";

  config = mkIf cfg.enable {
    environment.defaultPackages = [pkgs.kanata];

    # Enable the uinput module
    boot.kernelModules = ["uinput"];

    # Enable uinput
    hardware.uinput.enable = true;

    # Set up udev rules for uinput
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    # Ensure the uinput group exists
    users.groups.uinput = {};

    # Add the Kanata service user to necessary groupsT
    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = ["input" "uinput"];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            # Replace the paths below with the appropriate device paths for your setup.
            # Use `ls /dev/input/by-path/` to find your keyboard devices.
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
            "/dev/input/by-path/pci-0000:02:00.0-usb-0:5:1.0-event-kbd"
            "/dev/input/by-path/pci-0000:02:00.0-usb-0:5:1.2-event-kbd"
            "/dev/input/by-path/pci-0000:02:00.0-usbv2-0:5:1.0-event-kbd"
            "/dev/input/by-path/pci-0000:02:00.0-usbv2-0:5:1.2-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          port = 36413;
          config = builtins.readFile ./config.kbd;
        };
      };
    };
  };
}
