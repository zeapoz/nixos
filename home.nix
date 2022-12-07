{ options, config, lib, pkgs, ... }:
with lib;
{
  # Aliases for a better typing experience.
  # home-manager.users.${config.user.name}.xdg.configFile -> hm.configFile
  # home-manager.users.${config.user.name}.home.packages  -> hm.packages
  # home-manager.users.${config.user.name}.programs       -> hm.programs
  options = with types; {
    hm = {
      user = mkOpt attrs { };
      configFile = mkOpt attrs { };
      packages = mkOpt attrs { };
      programs = mkOpt attrs { };
    };
  };

  config = {
    home-manager.users.${config.user.name} = mkAliasDefinitions options.hm.user;

    hm.user = {
      home = {
        username = "${config.user.name}";
        homeDirectory = "/home/${config.user.name}";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "22.05";

        packages = mkAliasDefinitions options.hm.packages;
      };

      xdg.configFile = mkAliasDefinitions options.hm.configFile;
      programs = mkAliasDefinitions options.hm.programs;
    };

    # Let Home Manager install and manage itself.
    hm.programs.home-manager.enable = true;
  };
}
