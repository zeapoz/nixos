{
  imports = [./hardware-configuration.nix];

  modules = {
    desktop = {
      hyprland = {
        enable = true;
        autostart = true;
      };
      applications.gaming.enable = true;
    };

    dev.enable = true;
    shell.enable = true;
    theme.enable = true;
    hardware.bluetooth.enable = true;
  };

  # General settings.
  services.tlp.enable = true;

  # Custom defined options.
  hardware.hasBattery = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
