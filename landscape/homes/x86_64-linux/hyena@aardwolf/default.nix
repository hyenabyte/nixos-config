{ pkgs
, lib
, namespace
, ...
}:
with lib.${namespace}; {
  home.packages = with pkgs; [
    # Browser
    # chromium
    # vivaldi

    # Social
    signal-desktop
    beeper

    # Security
    bitwarden
    # protonvpn-gui
    # veracrypt
    # picocrypt

    # Office
    # tutanota-desktop
    # libreoffice-qt-fresh

    # Creative
    blender
    gimp
    inkscape
    krita

    # Media
    # spotify
    vlc
    # youtube-music

    # Games
    # itch
    lutris
    prismlauncher
    # r2modman
    # openrct2
    # pcsx2

    # Development
    # beekeeper-studio
    # bruno
    # godot
    # ldtk
    # trenchbroom
    # lapce
    # vscode
    # pulsar
    # vscodium
    slumber
    # openapi-tui

    # Utilities
    bartib
    # deluge
    # livecaptions
    # rpi-imager
    # testdisk
    # tigervnc
    # koboldcpp
    # podman-desktop
    # superfile
    # scope-tui
    # ventoy
  ];

  hyenabyte = {

    user = {
      enable = true;

      name = "hyena";
      fullName = "hyena";
      email = "hyena@hyenabyte.dev";
    };

    style = enabled;

    # impermanence = {
    #   enable = true;
    #   user = "hyena";
    # };

    shell.zsh = enabled;

    apps = {
      alacritty = enabled;
      aseprite = enabled;
      discord = enabled;
      # firefox = disabled;
      # librewolf = enabled;
      ghostty = enabled;
      logseq = enabled;
      # obs-studio = enabled;
      vesktop = enabled;
      # thunderbird = enabled;
      # zed = enabled;
      zen-browser = enabled;
    };

    cli = {
      bottom = enabled;
      clipse = enabled;
      gitui = enabled;
      helix = {
        enable = true;
        defaultEditor = true;
        # evil = true;
      };
      home-manager = enabled;
      hyfetch = enabled;
      fastfetch = enabled;
      yazi = enabled;
      zellij = enabled;
      lazygit = enabled;
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };
  };
}
