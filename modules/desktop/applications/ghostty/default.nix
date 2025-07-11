{config, ...}: {
  hm = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
    };

    configFile."ghostty".source = config.lib.meta.mkMutableSymlink ./.;
  };
}
