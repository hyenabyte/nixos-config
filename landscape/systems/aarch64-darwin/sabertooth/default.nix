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
      ];
      masApps = {
        Tailscale = 1475387142;
      };
    };

    system.fonts = enabled;

    apps = {
      aerospace = enabled;
      rectangle = enabled;
      # karabiner-elements = enabled;
    };

  };

  # environment.systemPackages = with pkgs; [];
  environment.systemPath = [ "/opt/homebrew/bin" ];

  system.stateVersion = 4;
}
