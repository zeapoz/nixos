{ config, lib }:
with lib; {
  userSettings = {
    # General settings.
    window = {
      zoomLevel = mkIf (config.networking.hostName == "neon") 1;
      menuBarVisibility = "toggle";
    };

    workbench = {
      iconTheme = "material-icon-theme";
      colorTheme = "Bluloco Dark";
    };

    editor = {
      fontFamily = "Fira Code";
      fontLigatures = true;
      cursorSmoothCaretAnimation = "on";
    };

    # Send ctrl+f to fish shell.
    terminal.integrated.commandsToSkipShell =
      [ "-workbench.action.terminal.focusFind" ];

    keyboard.dispatch = mkIf (config.networking.hostName == "neon") "keyCode";

    # Plugins.
    git = {
      autofetch = true;
      autoStash = true;
      allowForcePush = true;
      confirmSync = false;
      closeDiffOnOperation = true;
      enableSmartCommit = true;
      terminalGitEditor = true;
    };

    vim = {
      enableNeovim = config.modules.editors.neovim.enable;
      useSystemClipboard = true;
      foldfix = true;
      leader = " ";

      # Vim keybindings.
      normalModeKeyBindings = [
        {
          before = [ ":" ];
          commands = [ "workbench.action.showCommands" ];
        }
        {
          before = [ "<leader>" "f" ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [ "K" ];
          commands = [ "editor.action.showHover" ];
        }
        # Tabs.
        {
          before = [ "<leader>" "b" "d" ];
          commands = [ "workbench.action.closeActiveEditor" ];
        }
        {
          before = [ "<leader>" "b" "K" ];
          commands = [ "workbench.action.closeAllEditors" ];
        }
        # Navigating tabs.
        {
          before = [ "g" "l" ];
          commands = [ "workbench.action.nextEditor" ];
        }
        {
          before = [ "g" "h" ];
          commands = [ "workbench.action.previousEditor" ];
        }
        # Focusing areas.
        {
          before = [ "space" "o" "e" ];
          commands = [ "workbench.files.action.focusOpenEditorsView" ];
        }
        {
          before = [ "space" "o" "p" ];
          commands = [ "workbench.action.toggleSidebarVisibility" ];
        }
        # Folding code.
        {
          before = [ "<Tab>" ];
          commands = [ "editor.toggleFold" ];
        }
        {
          before = [ "<S-Tab>" ];
          commands = [ "editor.unfoldAll" ];
        }
      ];

      visualModeKeyBindings = [
        # Stay in visual mode after indenting.
        {
          before = [ ">" ];
          after = [ ">" "g" "v" ];
        }
        {
          before = [ "<" ];
          after = [ "<" "g" "v" ];
        }
        # Folding from selection.
        {
          before = [ "<Tab>" ];
          commands = [ "editor.createFoldingRangeFromSelection" ];
        }
      ];
    };
  };

  keybindings = [
    {
      key = "space f";
      command = "workbench.action.quickOpen";
      when = "!editorFocus && !inputFocus";
    }
    {
      key = "shift+;";
      command = "workbench.action.showCommands";
      when = "!editorFocus && !inputFocus";
    }
    # Navigating views.
    {
      key = "ctrl+w h";
      command = "workbench.action.navigateLeft";
    }
    {
      key = "ctrl+w ctrl+h";
      command = "workbench.action.navigateLeft";
    }
    {
      key = "ctrl+w l";
      command = "workbench.action.navigateRight";
    }
    {
      key = "ctrl+w ctrl+l";
      command = "workbench.action.navigateRight";
    }
    {
      key = "ctrl+w j";
      command = "workbench.action.navigateDown";
    }
    {
      key = "ctrl+w ctrl+j";
      command = "workbench.action.navigateDown";
    }
    {
      key = "ctrl+w k";
      command = "workbench.action.navigateUp";
    }
    {
      key = "ctrl+w ctrl+k";
      command = "workbench.action.navigateUp";
    }
    # Terminal.
    {
      key = "ctrl+j";
      command = "workbench.action.togglePanel";
      when =
        "!suggestWidgetMultipleSuggestions || !suggestWidgetVisible || !textInputFocus || !inQuickOpen";
    }
    # Navigating suggestions & pickers.
    {
      key = "ctrl+j";
      command = "selectNextSuggestion";
      when =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "ctrl+k";
      command = "selectPrevSuggestion";
      when =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "ctrl+j";
      command = "workbench.action.quickOpenSelectNext";
      when = "inQuickOpen";
    }
    {
      key = "ctrl+k";
      command = "workbench.action.quickOpenSelectPrevious";
      when = "inQuickOpen";
    }
  ];
}
