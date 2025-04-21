{
  config,
  lib,
  inputs,
  ...
}: {
  lib.meta = {
    configPath = "${config.hm.user.home.homeDirectory}/.config/NixOS";
    mkMutableSymlink = path: config.hm.user.lib.file.mkOutOfStoreSymlink (config.lib.meta.configPath + lib.removePrefix (toString inputs.self) (toString path));
  };
}
