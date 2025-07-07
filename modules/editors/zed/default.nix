{
  config,
  pkgs,
  ...
}: {
  hm = {
    packages = with pkgs; [zed-editor-fhs];

    configFile."zed/settings.json".source = config.lib.meta.mkMutableSymlink ./settings.json;
    configFile."zed/keymap.json".source = config.lib.meta.mkMutableSymlink ./keymap.json;
    configFile."zed/tasks.json".source = config.lib.meta.mkMutableSymlink ./tasks.json;
    configFile."zed/snippets".source = config.lib.meta.mkMutableSymlink ./snippets;
  };
}
