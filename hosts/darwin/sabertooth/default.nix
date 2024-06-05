{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # environment.shellInit = ''
  #   ulimit -n 2048
  #   '';

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brewPrefix = "/opt/homebrew/bin";

    caskArgs = {
      # no_quarantine = true;
    };

    brews = [
    ];

    casks = [
      # "beekeeper-studio"
      "beeper"
      # "blender"
      # "caffeine"
      # "chromium"
      # "deluge"
      # "discord"
      "firefox"
      # "font-agave-nerd-font"
      # "font-comic-shanns-mono-nerd-font"
      # "font-hurmit-nerd-font"
      # "font-iosevka"
      # "font-iosevka-nerd-font"
      # "font-iosevka-ss01"
      # "font-monofur-nerd-font"
      # "font-monoid-nerd-font"
      # "font-tinos-nerd-font"
      "karabiner-elements"
      # "minecraft"
      "protonvpn"
      "rectangle"
      "vlc"
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 4;
}
