{
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
  # home-manager.users.${config.user.name}.lib            -> hm.lib
  # home-manager.users.${config.user.name}.xdg.configFile -> hm.configFile
  # home-manager.users.${config.user.name}.home.packages  -> hm.packages
  # home-manager.users.${config.user.name}.home.file      -> hm.file
  # home-manager.users.${config.user.name}.programs       -> hm.programs
  # home-manager.users.${confis.user.name}.services       -> hm.services
  imports = [
    (mkAliasOptionModule ["hm" "user"] ["home-manager" "users" config.user.name])
    (mkAliasOptionModule ["hm" "lib"] ["home-manager" "users" config.user.name "lib" "meta"])
    (mkAliasOptionModule ["hm" "configFile"] ["home-manager" "users" config.user.name "xdg" "configFile"])
    (mkAliasOptionModule ["hm" "packages"] ["home-manager" "users" config.user.name "home" "packages"])
    (mkAliasOptionModule ["hm" "file"] ["home-manager" "users" config.user.name "home" "file"])
    (mkAliasOptionModule ["hm" "programs"] ["home-manager" "users" config.user.name "programs"])
    (mkAliasOptionModule ["hm" "services"] ["home-manager" "users" config.user.name "services"])
  ];

  config = {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
      };

      useGlobalPkgs = true;
      useUserPackages = true;

      users.${config.user.name} = {
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
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
      };
    };
  };
}
