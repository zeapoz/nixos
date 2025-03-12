{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    desktop = {
      hyprland = {
        enable = true;
        autostart = true;
      };
      applications = {
        browsers.enable = true;
        gaming.enable = true;
        media.enable = true;
      };
    };

    editors = {
      neovim = {
        enable = true;
        disableGui = true;
      };
    };

    dev.enable = true;
    shell.enable = true;
    theme.enable = true;
    hardware.bluetooth.enable = true;
  };

  # General settings.
  services.tlp.enable = true;

  # Home-manager settings.
  hm.packages = with pkgs; [brightnessctl];

  # Custom defined options.
  hardware.hasBattery = true;
}
