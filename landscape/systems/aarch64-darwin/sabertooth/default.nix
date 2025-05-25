{ lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Macbook Pro

  ${namespace} = {

    # virtualisation = {
    #   docker = enabled;
    # };

    services.nix-daemon = enabled;
    services.homebrew = {
      enable = true;
      brews = [ ];
      casks = [
        "firefox"
        "zen-browser"
        "beekeeper-studio"
        "protonvpn"
        "tabby"
        "karabiner-elements"
        "libreoffice"
        "ghostty"
        "deluge"
        "discord"
        "inkscape"
        "thunderbird"
        "zed"
        "bruno"
        "signal"
        "vlc"
        "prismlauncher"
      ];
      masApps = {
        Tailscale = 1475387142;
      };
    };

    system.fonts = enabled;

    apps = {
      # aerospace = enabled;
      rectangle = enabled;
      # karabiner-elements = enabled;
    };

  };

  environment.systemPackages = with pkgs; [
    snowfallorg.flake
  ];

  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
