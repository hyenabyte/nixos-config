{ pkgs
, lib
, namespace
, ...
}:
with lib.${namespace}; {
  home.packages = with pkgs; [
    # Browser
    vivaldi

    # Social
    # signal-desktop
    # beeper
    # slack

    # Security
    # bitwarden
    # protonvpn-gui
    # veracrypt
    # picocrypt

    # Office
    # tutanota-desktop
    # libreoffice-qt-fresh

    # Creative
    # blender
    # gimp
    # inkscape
    # krita

    # Media
    # spotify
    # vlc
    # youtube-music

    # Games
    # itch
    # lutris
    # prismlauncher
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
    # slumber
    # openapi-tui

    # Utilities
    # bartib
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
      fullName = "David Koch Gregersen";
      email = "dakg@jobindex.dk";
    };

    style = enabled;
    shell.zsh = enabled;

    apps = {
      alacritty = enabled;
      ghostty = enabled;
      librewolf = enabled;
      # logseq = enabled;
      # thunderbird = enabled;
      # vesktop = enabled;
      # zed = enabled;
      zen-browser = enabled;
    };

    cli = {
      bottom = enabled;
      clipse = enabled;
      fastfetch = enabled;
      gitui = enabled;
      helix = {
        enable = true;
        defaultEditor = true;
      };
      home-manager = enabled;
      hyfetch = enabled;
      lazygit = enabled;
      yazi = enabled;
      zellij = enabled;
    };

    tools = {
      direnv = enabled;
      git = {
        enable = true;
        # userName = "David Koch Gregersen";
        # userEmail = ""; # TODO work email goes here
      };
    };
  };
}
