{ lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro

    environment.systemPackages = with pkgs; [
      # firefox
      discord
      signal-desktop
      slack
      bruno
      zed-editor
      vlc-bin
      logseq
    ];

  ${namespace} = {

    services.nix-daemon = enabled;
    services.homebrew = {
      enable = true;
      brews = [ ];
      casks = [
        "zen-browser"
        "beekeeper-studio"
        "protonvpn"
        "tabby"
        # Fonts
        # "font-agave-nerd-font"
        # "font-iosevka-ss01"
      ];
      masApps = {
        Tailscale = 1475387142;
      };
    };

    apps = {
      rectangle = enabled;
      karabiner-elements = enabled;
    };
  };

  # environment.systemPackages = with pkgs; [];
  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
