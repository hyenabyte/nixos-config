{ lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro
  ${namespace} = {
    environment.packages = with pkgs; [
      firefox
      discord
      signal-desktop
      slack
      bruno
      zed-editor
      vlc-bin
      logseq
    ];

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
    };
  };

  # environment.systemPackages = with pkgs; [];
  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
