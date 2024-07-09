{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro

  # homebrew = {
  #   enable = true;

  # onActivation = {
  #   autoUpdate = true;
  #   cleanup = "zap";
  #   upgrade = true;
  # };

  # brewPrefix = "/opt/homebrew/bin";

  # caskArgs = {
  #   # no_quarantine = true;
  # };

  #   brews = [
  #   ];

  #   casks = [
  #     # "beekeeper-studio"
  #     "beeper"
  #     # "blender"
  #     # "caffeine"
  #     # "chromium"
  #     # "deluge"
  #     "discord"
  #     "firefox"
  #     "font-agave-nerd-font"
  #     # "font-comic-shanns-mono-nerd-font"
  #     # "font-hurmit-nerd-font"
  #     # "font-iosevka"
  #     # "font-iosevka-nerd-font"
  #     "font-iosevka-ss01"
  #     # "font-monofur-nerd-font"
  #     # "font-monoid-nerd-font"
  #     # "font-tinos-nerd-font"
  #     "karabiner-elements"
  #     # "minecraft"
  #     "protonvpn"
  #     "rectangle"
  #     "vlc"
  #     #"deluge"
  #     "spotify"
  #     #prismlauncher
  #     #blender
  #     #inkscape
  #     #gimp
  #     "tabby"
  #     "logseq"
  #     "signal"
  #     "steam"
  #   ];
  # };

  # environment.systemPackages = with pkgs; [];

  system.stateVersion = 4;
}
