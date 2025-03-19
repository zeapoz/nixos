{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  # Recursively import all nix modules that are not this file.
  imports = lib.filter (n: !lib.strings.hasInfix "home/default.nix" n && lib.strings.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive (builtins.toString ./.));
in {
  # Aliases for a better typing experience.
  # home-manager.users.${config.user.name}                -> hm.user
  # home-manager.users.${config.user.name}.xdg.configFile -> hm.configFile
  # home-manager.users.${config.user.name}.home.packages  -> hm.packages
  # home-manager.users.${config.user.name}.home.file      -> hm.file
  # home-manager.users.${config.user.name}.programs       -> hm.programs
  # home-manager.users.${config.user.name}.services       -> hm.services
  options = with types; {
    hm = {
      user = mkOpt attrs {};
      file = mkOpt attrs {};
      configFile = mkOpt attrs {};
      packages = mkOpt attrs {};
      programs = mkOpt attrs {};
      services = mkOpt attrs {};
    };
  };

  config = {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
      };

      useGlobalPkgs = true;
      useUserPackages = true;

      users.${config.user.name} = mkAliasDefinitions options.hm.user;
    };

    hm.user = {
      inherit imports;

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
        file = mkAliasDefinitions options.hm.file;
      };

      xdg.configFile = mkAliasDefinitions options.hm.configFile;
      programs = mkAliasDefinitions options.hm.programs;
      services = mkAliasDefinitions options.hm.services;
    };

    # Let Home Manager install and manage itself.
    hm.programs.home-manager.enable = true;
  };
}
