{ config, lib, pkgs, ... }:

{
  home-manager.users.${config.user.name} = {
    home = {
      username = "${config.user.name}";
      homeDirectory = "/home/${config.user.name}";

      # Packages that should be installed to the user profile.
      packages = with pkgs; [
        anki
        discord
        helvum
        libreoffice
        neofetch
        pavucontrol
        playerctl
        prismlauncher
        pulseaudio
        python3
        ranger
        signal-desktop
      ];

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "22.05";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
