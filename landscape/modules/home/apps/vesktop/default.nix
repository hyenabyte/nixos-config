{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vesktop;

  jsonFormat = pkgs.formats.json {};
in {
  options.${namespace}.apps.vesktop = {enable = mkEnableOption "Enable Vesktop";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];

    xdg.configFile = let
      plugins = {
        ChatInputButtonAPI.enabled = false;
        CommandsAPI.enabled = true;
        MemberListDecoratorsAPI.enabled = false;
        MessageAccessoriesAPI.enabled = true;
        MessageDecorationsAPI.enabled = false;
        MessageEventsAPI.enabled = false;
        MessagePopoverAPI.enabled = false;
        MessageUpdaterAPI.enabled = false;
        ServerListAPI.enabled = false;
        UserSettingsAPI.enabled = true;
        AlwaysAnimate.enabled = false;
        AlwaysTrust.enabled = false;
        AnonymiseFileNames.enabled = false;
        AppleMusicRichPresence.enabled = false;
        "WebRichPresence (arRPC)".enabled = false;
        AutomodContext.enabled = false;
        BANger.enabled = false;
        BetterFolders.enabled = false;
        BetterGifAltText.enabled = false;
        BetterGifPicker.enabled = false;
        BetterNotesBox.enabled = false;
        BetterRoleContext.enabled = false;
        BetterRoleDot.enabled = false;
        BetterSessions.enabled = false;
        BetterSettings.enabled = false;
        BetterUploadButton.enabled = false;
        BiggerStreamPreview.enabled = false;
        BlurNSFW.enabled = false;
        CallTimer.enabled = false;
        ClearURLs.enabled = false;
        ClientTheme.enabled = false;
        ColorSighted.enabled = false;
        ConsoleJanitor.enabled = false;
        ConsoleShortcuts.enabled = false;
        CopyEmojiMarkdown.enabled = false;
        CopyUserURLs.enabled = false;
        CrashHandler.enabled = true;
        CtrlEnterSend.enabled = false;
        CustomRPC.enabled = false;
        CustomIdle.enabled = false;
        Dearrow.enabled = false;
        Decor.enabled = false;
        DisableCallIdle.enabled = false;
        DontRoundMyTimestamps.enabled = false;
        EmoteCloner.enabled = false;
        Experiments.enabled = false;
        F8Break.enabled = false;
        FakeNitro.enabled = false;
        FakeProfileThemes.enabled = false;
        FavoriteEmojiFirst.enabled = false;
        FavoriteGifSearch.enabled = false;
        FixCodeblockGap.enabled = false;
        FixSpotifyEmbeds.enabled = false;
        FixYoutubeEmbeds.enabled = false;
        ForceOwnerCrown.enabled = false;
        FriendInvites.enabled = false;
        FriendsSince.enabled = false;
        GameActivityToggle.enabled = false;
        GifPaste.enabled = false;
        GreetStickerPicker.enabled = false;
        HideAttachments.enabled = false;
        iLoveSpam.enabled = false;
        IgnoreActivities.enabled = false;
        ImageLink.enabled = false;
        ImageZoom.enabled = false;
        ImplicitRelationships = {
          enabled = true;
          sortByAffinity = true;
        };
        InvisibleChat.enabled = false;
        KeepCurrentChannel.enabled = false;
        LastFMRichPresence.enabled = false;
        LoadingQuotes = {
          enabled = false;
          replaceEvents = true;
          enablePluginPresetQuotes = true;
          enableDiscordPresetQuotes = false;
          additionalQuotes = "";
          additionalQuotesDelimiter = "|";
        };
        MaskedLinkPaste.enabled = false;
        MemberCount = {
          enabled = true;
          memberList = true;
          toolTip = true;
        };
        MessageClickActions.enabled = false;
        MessageLatency.enabled = false;
        MessageLinkEmbeds.enabled = false;
        MessageLogger.enabled = false;
        MessageTags.enabled = false;
        MoreCommands.enabled = false;
        MoreKaomoji.enabled = true;
        MoreUserTags.enabled = false;
        Moyai = {
          enabled = false;
          volume = 0.5;
          quality = "Normal";
          triggerWhenUnfocused = true;
          ignoreBots = true;
          ignoreBlocked = true;
        };
        MutualGroupDMs.enabled = false;
        NewGuildSettings.enabled = false;
        NoBlockedMessages.enabled = false;
        NoDefaultHangStatus.enabled = false;
        NoDevtoolsWarning.enabled = false;
        NoF1.enabled = false;
        NoMosaic.enabled = false;
        NoOnboardingDelay.enabled = false;
        NoPendingCount.enabled = false;
        NoProfileThemes.enabled = false;
        NoReplyMention.enabled = false;
        NoScreensharePreview.enabled = false;
        NoServerEmojis.enabled = false;
        NoTypingAnimation.enabled = false;
        NoUnblockToJump.enabled = false;
        NormalizeMessageLinks.enabled = false;
        NotificationVolume.enabled = false;
        NSFWGateBypass.enabled = false;
        OnePingPerDM.enabled = false;
        oneko.enabled = true;
        OpenInApp.enabled = false;
        OverrideForumDefaults.enabled = false;
        PartyMode.enabled = false;
        PauseInvitesForever.enabled = false;
        PermissionFreeWill.enabled = false;
        PermissionsViewer.enabled = false;
        petpet.enabled = false;
        PictureInPicture.enabled = false;
        PinDMs.enabled = false;
        PlainFolderIcon.enabled = false;
        PlatformIndicators.enabled = false;
        PreviewMessage.enabled = false;
        PronounDB.enabled = false;
        QuickMention.enabled = false;
        QuickReply.enabled = false;
        ReactErrorDecoder.enabled = false;
        ReadAllNotificationsButton.enabled = false;
        RelationshipNotifier.enabled = false;
        ReplaceGoogleSearch.enabled = false;
        ReplyTimestamp.enabled = false;
        RevealAllSpoilers.enabled = false;
        ReverseImageSearch.enabled = false;
        ReviewDB.enabled = false;
        RoleColorEverywhere.enabled = false;
        SearchReply.enabled = false;
        SecretRingToneEnabler.enabled = false;
        Summaries.enabled = false;
        SendTimestamps.enabled = false;
        ServerInfo.enabled = false;
        ServerListIndicators.enabled = false;
        ShikiCodeblocks.enabled = false;
        ShowAllMessageButtons.enabled = false;
        ShowAllRoles.enabled = false;
        ShowConnections.enabled = false;
        ShowHiddenChannels.enabled = false;
        ShowHiddenThings.enabled = false;
        ShowMeYourName.enabled = false;
        ShowTimeoutDuration.enabled = false;
        SilentMessageToggle.enabled = false;
        SilentTyping.enabled = false;
        SortFriendRequests.enabled = false;
        SpotifyControls.enabled = false;
        SpotifyCrack.enabled = false;
        SpotifyShareCommands.enabled = false;
        StartupTimings.enabled = false;
        StreamerModeOnStream.enabled = false;
        SuperReactionTweaks.enabled = false;
        TextReplace.enabled = false;
        ThemeAttributes.enabled = false;
        TimeBarAllActivities.enabled = false;
        Translate.enabled = false;
        TypingIndicator.enabled = false;
        TypingTweaks.enabled = false;
        Unindent.enabled = false;
        UnlockedAvatarZoom.enabled = false;
        UnsuppressEmbeds.enabled = false;
        UserVoiceShow.enabled = false;
        USRBG.enabled = false;
        ValidReply.enabled = false;
        ValidUser.enabled = false;
        VoiceChatDoubleClick.enabled = false;
        VcNarrator.enabled = false;
        VencordToolbox.enabled = false;
        ViewIcons.enabled = false;
        ViewRaw.enabled = false;
        VoiceDownload.enabled = false;
        VoiceMessages.enabled = false;
        WatchTogetherAdblock.enabled = false;
        WebKeybinds.enabled = true;
        WebScreenShareFixes.enabled = true;
        WhoReacted.enabled = false;
        XSOverlay.enabled = false;
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        WebContextMenus = {
          enabled = true;
          addBack = true;
        };
        Settings = {
          enabled = true;
          settingsLocation = "aboveNitro";
        };
        SupportHelper.enabled = true;
      };

      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        themeLinks = [];
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
    in {
      "vesktop/themes/midnight-everforest.theme.css".source = ./themes/midnight-everforest.theme.css;
      "vesktop/settings/quickCss.css".text = "";
      "vesktop/settings/settings.json".source = jsonFormat.generate "vesktop-settings" settings;
    };
  };
}