{ config, lib, inputs, ... }:

{
  lib.meta = {
    configPath = "${config.home.homeDirectory}/.config/NixOS";
    mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink (config.lib.meta.configPath + lib.removePrefix (toString inputs.self) (toString path));
  };
}
