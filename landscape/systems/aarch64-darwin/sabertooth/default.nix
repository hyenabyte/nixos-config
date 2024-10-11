{ lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro
  ${namespace} = {
    services.nix-daemon = enabled;
    services.homebrew = {
      enable = true;
      brews = [ ];
      casks = [
        # Apps
        # "chromium"
        "firefox"

        # Creative
        # "blender"
        #inkscape
        #gimp


        # Socials
        "beeper"
        "discord"
        "signal"
        "slack"

        # Dev
        "beekeeper-studio"
        "bruno"
        "visual-studio-code"
        #"vscodium"

        # Games
        #"steam"
        #prismlauncher
        # "minecraft"

        # Utilities
        "karabiner-elements"
        "logi-options+"


        # Fonts
        "font-agave-nerd-font"
        # "font-comic-shanns-mono-nerd-font"
        # "font-hurmit-nerd-font"
        # "font-iosevka"
        # "font-iosevka-nerd-font"
        "font-iosevka-ss01"
        # "font-monofur-nerd-font"
        # "font-monoid-nerd-font"
        # "font-tinos-nerd-font"


        # "caffeine"
        # "deluge"

        "protonvpn"
        "rectangle"
        "vlc"
        # "deluge"
        # "spotify"

        "tabby"
        "logseq"


      ];
    };
  };

  # environment.systemPackages = with pkgs; [];
  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
