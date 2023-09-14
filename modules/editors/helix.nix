{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editors.helix;
in {
  options.modules.editors.helix.enable = mkEnableOption "helix";

  config = mkIf cfg.enable {
    hm.programs.helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor = {
          cursorline = true;
          cursor-shape.insert = "bar";
          completion-trigger-len = 1;
          idle-timeout = 0;
          auto-save = true;
          color-modes = true;
          shell = ["fish" "-c"];
          bufferline = "multiple";
          lsp.display-messages = true;
          file-picker.hidden = false;
          indent-guides.render = true;
        };
      };
      languages = {
        language = [
          {
            name = "rust";
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "`" = "`";
              "<" = ">";
            };
          }
          {
            name = "nix";
            auto-format = true;
            formatter.command = "nixpkgs-fmt";
          }
        ];
      };
    };
  };
}
