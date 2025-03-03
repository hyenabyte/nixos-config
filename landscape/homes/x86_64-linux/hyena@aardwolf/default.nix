{ pkgs
, lib
, namespace
, ...
}:
with lib.${namespace}; {
  home.packages = with pkgs; [
    # Browser
    # chromium
    vivaldi

    # Social
    signal-desktop
    beeper

    # Security
    bitwarden
    protonvpn-gui
    veracrypt
    picocrypt

    # Office
    # tutanota-desktop
    libreoffice-qt-fresh

    # Creative
    blender

    # Utilities
    deluge
    # livecaptions
    # rpi-imager
    # testdisk
    # tigervnc
    koboldcpp
    podman-desktop
  ];

  hyenabyte = {
    user = enabled;
    shell.zsh = enabled;

    apps = {
      alacritty = enabled;
      aseprite = enabled;
      # discord = enabled;
      firefox = enabled;
      ghostty = enabled;
      kitty = enabled;
      logseq = enabled;
      obs-studio = enabled;
      vesktop = enabled;
      # thunderbird = enabled;
      zed = enabled;
      zen-browser = enabled;
    };

    cli = {
      bottom = enabled;
      helix = {
        enable = true;
        defaultEditor = true;
      };
      home-manager = enabled;
      hyfetch = enabled;
      yazi = enabled;
      zellij = enabled;
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };
  };
}
