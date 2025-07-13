{
  config,
  pkgs,
  ...
}: {
  hm = {
    packages = with pkgs; [zed-editor-fhs];

    configFile = {
      "zed/settings.json".source = config.lib.meta.mkMutableSymlink ./settings.json;
      "zed/keymap.json".source = config.lib.meta.mkMutableSymlink ./keymap.json;
      "zed/tasks.json".source = config.lib.meta.mkMutableSymlink ./tasks.json;
      "zed/snippets".source = config.lib.meta.mkMutableSymlink ./snippets;
    };
  };
}
