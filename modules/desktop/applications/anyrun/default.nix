{
  config,
  pkgs,
  inputs,
  ...
}: {
  hm = {
    programs.anyrun = {
      enable = true;
      config = {
        x = {fraction = 0.5;};
        y = {fraction = 0.3;};
        width = {fraction = 0.2;};
        hidePluginInfo = true;
        closeOnClick = true;
        showResultsImmediately = true;
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          symbols
          rink
          shell
          translate
          kidex
          randr
          dictionary
          websearch
        ];
      };
    };

    configFile."anyrun/style.css".source = config.lib.meta.mkMutableSymlink ./style.css;
  };
}
