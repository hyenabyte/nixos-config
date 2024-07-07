{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.firefox;
in {
  options.${namespace}.apps.firefox = {enable = mkEnableOption "Enable Firefox";};

  config = mkIf cfg.enable {
    ${namespace}.home.programs.firefox = {
      enable = true;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          adnauseam
          bitwarden
          cookie-autodelete
          facebook-container
          multi-account-containers
          flagfox
          offline-qr-code-generator
          return-youtube-dislikes
          simplelogin
          sponsorblock
          streetpass-for-mastodon
          tree-style-tab

          # ublock-origin
          # decentraleyes
          # firefox-color
          # localcdn
          # privacy-badger
          # vimium
        ];

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
          order = ["DuckDuckGo" "Google"];
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
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
            "MyNixOS" = {
              urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
              iconUpdateURL = "https://mynixos.com/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@mno"];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };

      # Privacy about:config settings
      # profiles.notus = {
      #     settings = {
      #         "browser.send_pings" = false;
      #         "browser.urlbar.speculativeConnect.enabled" = false;
      #         "dom.event.clipboardevents.enabled" = true;
      #         "media.navigator.enabled" = false;
      #         "network.cookie.cookieBehavior" = 1;
      #         "network.http.referer.XOriginPolicy" = 2;
      #         "network.http.referer.XOriginTrimmingPolicy" = 2;
      #         "beacon.enabled" = false;
      #         "browser.safebrowsing.downloads.remote.enabled" = false;
      #         "network.IDN_show_punycode" = true;
      #         "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      #         "app.shield.optoutstudies.enabled" = false;
      #         "dom.security.https_only_mode_ever_enabled" = true;
      #         "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      #         "browser.toolbars.bookmarks.visibility" = "never";
      #         "geo.enabled" = false;

      #         # Disable telemetry
      #         "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      #         "browser.ping-centre.telemetry" = false;
      #         "browser.tabs.crashReporting.sendReport" = false;
      #         "devtools.onboarding.telemetry.logged" = false;
      #         "toolkit.telemetry.enabled" = false;
      #         "toolkit.telemetry.unified" = false;
      #         "toolkit.telemetry.server" = "";

      #         # Disable Pocket
      #         "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      #         "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      #         "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      #         "browser.newtabpage.activity-stream.showSponsored" = false;
      #         "extensions.pocket.enabled" = false;

      #         # Disable prefetching
      #         "network.dns.disablePrefetch" = true;
      #         "network.prefetch-next" = false;

      #         # Disable JS in PDFs
      #         "pdfjs.enableScripting" = false;

      #         # Harden SSL
      #         "security.ssl.require_safe_negotiation" = true;

      #         # Extra
      #         "identity.fxaccounts.enabled" = false;
      #         "browser.search.suggest.enabled" = false;
      #         "browser.urlbar.shortcuts.bookmarks" = false;
      #         "browser.urlbar.shortcuts.history" = false;
      #         "browser.urlbar.shortcuts.tabs" = false;
      #         "browser.urlbar.suggest.bookmark" = false;
      #         "browser.urlbar.suggest.engines" = false;
      #         "browser.urlbar.suggest.history" = false;
      #         "browser.urlbar.suggest.openpage" = false;
      #         "browser.urlbar.suggest.topsites" = false;
      #         "browser.uidensity" = 1;
      #         "media.autoplay.enabled" = false;
      #         "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";

      #         "privacy.firstparty.isolate" = true;
      #         "network.http.sendRefererHeader" = 0;
      #     };
    };
  };
}
