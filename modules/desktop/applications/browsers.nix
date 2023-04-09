{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.applications.browsers;
in {
  options.modules.desktop.applications.browsers.enable =
    mkEnableOption "browsers";

  config = mkIf cfg.enable {
    hm = {
      packages = with pkgs; [ brave ];

      programs.librewolf = {
        enable = true;
        package = pkgs.librewolf-wayland;
      };

      programs.firefox = {
        enable = true;
        profiles.default = {
          search.default = "DuckDuckGo";
          search.engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
          };
        };
      };

      # Custom firefox userchrome theme, see details on
      # https://github.com/Godiesc/firefox-gx
      file.".mozilla/firefox/default" = {
        source = pkgs.fetchzip {
          url = "https://github.com/Godiesc/firefox-gx/releases/download/v.7.6/FirefoxGX_Release_v.111.zip";
          sha256 = "sha256-qf1O9eesgJXVz0GxGOzN6mlu9aBEnr3us6iRkaRZE5Q=";
        };
        recursive = true;
      };
    };
  };
}
