{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = { enable = mkEnableOption "Enable Firefox"; };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

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
          # Homepage
          # "browser.startup.homepage" = "https://duckduckgo.com";

          # Search Engine
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          # Don't close window when closing last tab
          "browser.tabs.closeWindowWithLastTab" = false;
        };

        search = {
          force = true;
          default = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
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
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "MyNixOS" = {
              urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
              iconUpdateURL = "https://mynixos.com/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@mno" ];
            };
            "Github" = {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@gh" ];
            };
            "Github Users" = {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=users"; }];
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@ghu" ];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
    };
  };
}
