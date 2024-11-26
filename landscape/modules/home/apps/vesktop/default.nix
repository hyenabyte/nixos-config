{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vesktop;

  jsonFormat = pkgs.formats.json { };
in
{
  options.${namespace}.apps.vesktop = { enable = mkEnableOption "Enable Vesktop"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];

    xdg.configFile =
      let
        plugins = {
          # Core
          # Disable Discord's tracking (analytics/'science')
          NoTrack = {
            enabled = true;
            disableAnalytics = true;
          };
          # Adds Settings UI and debug info
          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
          };
          # Helps us provide support to you
          SupportHelper.enabled = true;

          # API
          # API to add badges to users.
          BadgeAPI.enabled = false;
          # API to add buttons to the chat input
          ChatInputButtonAPI.enabled = true;
          # Api required by anything that uses commands
          CommandsAPI.enabled = true;
          # API for adding/removing items to/from context menus.
          ContextMenuAPI.enabled = false;
          # Allows you to omit either width or height when opening an image modal
          DynamicImageModalAPI.enabled = false;
          # API to add decorators to member list (both in servers and DMs)
          MemberListDecoratorsAPI.enabled = false;
          # API to add message accessories.
          MessageAccessoriesAPI.enabled = true;
          # API to add decorations to messages
          MessageDecorationsAPI.enabled = false;
          # Api required by anything using message events.
          MessageEventsAPI.enabled = true;
          # API to add buttons to message popovers.
          MessagePopoverAPI.enabled = false;
          # API for updating and re-rendering messages.
          MessageUpdaterAPI.enabled = false;
          # Fixes notices being automatically dismissed
          NoticesAPI.enabled = false;
          # Api required for plugins that modify the server list
          ServerListAPI.enabled = false;
          # Patches Discord's UserSettings to expose their group and name.
          UserSettingsAPI.enabled = true;

          # Plugins
          ClearURLs.enabled = true;
          CrashHandler.enabled = true;
          ImplicitRelationships = {
            enabled = true;
            sortByAffinity = true;
          };
          LoadingQuotes = {
            enabled = true;
            replaceEvents = true;
            enablePluginPresetQuotes = true;
            enableDiscordPresetQuotes = false;
            additionalQuotes = ":3|What a time to be alive!|Not today|Quotes? What quotes?";
            additionalQuotesDelimiter = "|";
          };
          MemberCount = {
            enabled = true;
            memberList = true;
            toolTip = true;
          };
          MentionAvatars.enabled = true;
          MoreKaomoji.enabled = true;
          oneko.enabled = true;
          PreviewMessage.enabled = true;
          SendTimestamps.enabled = true;
          ShowMeYourName = {
            enabled = true;
            mode = "nick-user";
            displayNames = false;
            inReplies = false;
          };
          SilentMessageToggle = {
            enabled = true;
            persistState = false;
            autoDisable = true;
          };
          ThemeAttributes.enabled = true;
          UserMessagesPronouns = {
            enabled = true;
            pronounsFormat = "LOWERCASE";
            showSelf = true;
          };
          VoiceChatDoubleClick.enabled = true;
          VolumeBooster = {
            enabled = true;
            multiplier = 2;
          };
          WebContextMenus = {
            enabled = true;
            addBack = true;
          };
          WebKeybinds.enabled = true;
          "WebRichPresence (arRPC)".enabled = true;
          WebScreenShareFixes.enabled = true;
        };

        settings = {
          autoUpdate = true;
          autoUpdateNotification = true;
          useQuickCss = true;
          themeLinks = [ ];
          enabledThemes = [
            "midnight-everforest.theme.css"
          ];
          enableReactDevTools = false;
          frameless = false;
          transparent = false;
          winCtrlQ = false;
          disableMinSize = false;
          winNativeTitleBar = false;
          inherit plugins;
          notifications = {
            timeout = 5000;
            position = "bottom-right";
            useNative = "not-focused";
            logLimit = 50;
          };
          cloud = {
            authenticated = false;
            url = "https://api.vencord.dev";
            settingsSync = false;
            settingsSyncVersion = 1720887450787;
          };
        };
      in
      {
        "vesktop/themes/midnight-everforest.theme.css".source = ./themes/midnight-everforest.theme.css;
        "vesktop/settings/quickCss.css".text = "";
        "vesktop/settings/settings.json".source = jsonFormat.generate "vesktop-settings" settings;
      };
  };
}
