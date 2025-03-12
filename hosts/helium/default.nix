{...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    desktop = {
      hyprland = {
        enable = true;
        autostart = true;
      };
      applications = {
        browsers.enable = true;
        gaming = {
          enable = true;
          enableStreaming = true;
        };
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
    hardware = {
      keychron.enable = true;
      bluetooth.enable = true;
    };
  };
}
