{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    anyrun = {
      enable = true;
      config = {
        x = {fraction = 0.5;};
        y = {fraction = 0.3;};
        width = {fraction = 0.3;};
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
      extraCss = ''
        * {
          all: unset;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        #match.activatable {
          border-radius: 10px;
          margin: 4px 2px;
          padding: 0 8px;
        }
        #match.activatable:first-child {
          margin-top: 12px;
        }
        #match.activatable:last-child {
          margin-bottom: 0;
        }

        #match:hover {
          background: rgba(255, 255, 255, 0.05);
        }
        #match:selected {
          background: rgba(255, 255, 255, 0.1);
        }

        #entry {
          background: rgba(255, 255, 255, 0.05);
          border: 1px solid rgba(255, 255, 255, 0.1);
          border-radius: 8px;
          padding: 4px 8px;
        }

        box#main {
          background: rgba(0, 0, 0, 0.4);
          padding: 12px;
          border-radius: 10px;
        }
      '';
    };
  };
}
