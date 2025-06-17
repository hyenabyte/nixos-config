{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.zen-browser;
in
{
  options.${namespace}.apps.zen-browser = { enable = mkEnableOption "Enable Zen Browser"; };

  config = mkIf cfg.enable {
    home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #   adnauseam
        #   bitwarden
        #   cookie-autodelete
        #   facebook-container
        #   multi-account-containers
        #   flagfox
        #   offline-qr-code-generator
        #   return-youtube-dislikes
        #   simplelogin
        #   sponsorblock
        #   streetpass-for-mastodon
        #   tree-style-tab

        #   # ublock-origin
        #   # decentraleyes
        #   # firefox-color
        #   # localcdn
        #   # privacy-badger
        #   # vimium
        # ];

        settings = {
          # Search Engine
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          # Don't close window when closing last tab
          "browser.tabs.closeWindowWithLastTab" = false;
        };

        search = {
          force = true;
          default = "ddg";
          order = [ "ddg" "google" ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              icon = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "MyNixOS" = {
              urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
              icon = "https://mynixos.com/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@mno" ];
            };
            "Github" = {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
              icon = "https://github.githubassets.com/favicons/favicon-dark.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@gh" ];
            };
            "Github Users" = {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=users"; }];
              icon = "https://github.githubassets.com/favicons/favicon-dark.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@ghu" ];
            };
            "ProtonDB" = {
              urls = [{ template = "https://www.protondb.com/search?q={searchTerms}"; }];
              icon = "https://www.protondb.com/sites/protondb/images/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@proton" ];
            };
            "Alternativeto" = {
              urls = [{ template = "https://alternativeto.net/browse/search?q={searchTerms}"; }];
              icon = "https://alternativeto.net/static/logo.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@alternativeto" ];
            };
            bing.metaData.hidden = true;
            google.metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
    };
  };
}
