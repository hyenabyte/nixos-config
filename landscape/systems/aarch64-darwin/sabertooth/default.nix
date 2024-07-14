{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro
  ${namespace} = {
    services.nix-daemon = enabled;
    services.homebrew = {
      enable = true;
      brews = [];
      casks = [
        # "beekeeper-studio"
        "beeper"
        # "blender"
        # "caffeine"
        # "chromium"
        # "deluge"
        "discord"
        "firefox"
        "font-agave-nerd-font"
        # "font-comic-shanns-mono-nerd-font"
        # "font-hurmit-nerd-font"
        # "font-iosevka"
        # "font-iosevka-nerd-font"
        "font-iosevka-ss01"
        # "font-monofur-nerd-font"
        # "font-monoid-nerd-font"
        # "font-tinos-nerd-font"
        "karabiner-elements"
        # "minecraft"
        "protonvpn"
        "rectangle"
        "vlc"
        "vscodium"
        #"deluge"
        "spotify"
        #prismlauncher
        #blender
        #inkscape
        #gimp
        "tabby"
        "logseq"
        "signal"
        "steam"
      ];
    };
  };

  # environment.systemPackages = with pkgs; [];
  environment.systemPath = ["/opt/homebrew/bin"];

  system.stateVersion = 4;
}
