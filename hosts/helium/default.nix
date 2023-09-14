_: let
  mainDesktop = "hyprland";
  mainEditor = "codium";
in {
  imports = [./hardware-configuration.nix];

  modules = {
    desktop = {
      ${mainDesktop} = {
        enable = true;
        autostart = true;
      };
      waybar = {
        mainDesktop = "${mainDesktop}";
        temperaturePath = "/sys/module/k10temp/drivers/pci:k10temp/0000:00:18.3/hwmon/hwmon1/temp1_input";
        keyboardPath = "/dev/input/event3";
      };
      applications = {
        browsers.enable = true;
        gaming.enable = true;
        media = {
          enable = true;
          daw.enable = true;
        };
      };
    };

    editors = {
      inherit mainEditor;
      helix.enable = true;
      neovim.enable = true;
      vscode.enable = true;
    };

    dev.enable = true;
    shell.enable = true;
    theme.enable = true;
    hardware.keychron.enable = true;
  };

  # Home-manager settings.
  hm.programs.kitty.font.size = 12;
}
