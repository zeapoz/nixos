{
  userSettings = {
    # General settings.
    "window.zoomLevel" = 1;
    "window.menuBarVisibility" = "toggle";

    "workbench.iconTheme" = "material-icon-theme";
    "workbench.colorTheme" = "Ayu Mirage";

    "editor.fontFamily" = "'Fira Code'";
    "editor.fontLigatures" = true;
    "editor.cursorSmoothCaretAnimation" = true;

    "keyboard.dispatch" = "keyCode";

    # Plugins.
    "git.autofetch" = true;

    "nix.formatterPath" = "nixfmt";

    "vim.enableNeovim" = true;
    "vim.useSystemClipboard" = true;
    "vim.leader" = " ";

    # Vim keybindings.
    "vim.normalModeKeyBindings" = [
      {
        "before" = [ ":" ];
        "commands" = [ "workbench.action.showCommands" ];
      }
      {
        "before" = [ "<leader>" "f" ];
        "commands" = [ "workbench.action.quickOpen" ];
      }
      {
        "before" = [ "K" ];
        "commands" = [ "editor.action.showHover" ];
      }
      # Tabs.
      {
        "before" = [ "<leader>" "b" "d" ];
        "commands" = [ "workbench.action.closeActiveEditor" ];
      }
      {
        "before" = [ "<leader>" "b" "K" ];
        "commands" = [ "workbench.action.closeAllEditors" ];
      }
      # Navigating tabs.
      {
        "before" = [ "<Tab>" ];
        "commands" = [ "workbench.action.nextEditor" ];
      }
      {
        "before" = [ "<S-Tab>" ];
        "commands" = [ "workbench.action.previousEditor" ];
      }
    ];
    # Stay in visual mode after indenting.
    "vim.visualModeKeyBindings" = [
      {
        "before" = [ ">" ];
        "after" = [ ">" "g" "v" ];
      }
      {
        "before" = [ "<" ];
        "after" = [ "<" "g" "v" ];
      }
    ];
  };

  keybindings = [
    {
      "key" = "space f";
      "command" = "workbench.action.quickOpen";
      "when" = "!editorFocus && !inputFocus";
    }
    {
      "key" = "shift+;";
      "command" = "workbench.action.showCommands";
      "when" = "!editorFocus && !inputFocus";
    }
    # Navigating views.
    {
      "key" = "ctrl+w h";
      "command" = "workbench.action.navigateLeft";
    }
    {
      "key" = "ctrl+w ctrl+h";
      "command" = "workbench.action.navigateLeft";
    }
    {
      "key" = "ctrl+w l";
      "command" = "workbench.action.navigateRight";
    }
    {
      "key" = "ctrl+w ctrl+l";
      "command" = "workbench.action.navigateRight";
    }
    # Navigating suggestions & pickers.
    {
      "key" = "ctrl+j";
      "command" = "selectNextSuggestion";
      "when" =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      "key" = "ctrl+k";
      "command" = "selectPrevSuggestion";
      "when" =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      "key" = "ctrl+j";
      "command" = "workbench.action.quickOpenSelectNext";
      "when" = "inQuickOpen";
    }
    {
      "key" = "ctrl+k";
      "command" = "workbench.action.quickOpenSelectPrevious";
      "when" = "inQuickOpen";
    }
  ];
}