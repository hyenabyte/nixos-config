{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../../modules/packages
    ../../../users/hyena/home.nix
  ];

  config = {
    home.stateVersion = "23.11";

    # Modules
    modules = {
      # cli
      zellij.enable = true;

      # gui
      alacritty.enable = true;
      firefox.enable = true;
      nextcloud-client.enable = true;
      obs-studio.enable = true;
      vscode.enable = true;
      thunderbird.enable = true;
      # logseq.enable = true;
    };

    # Packages
    home.packages = with pkgs; [
      ### Applications   ###
      bitwarden
      deluge
      # floorp
      # gnome.gnome-boxes
      protonvpn-gui
      veracrypt
      # vivaldi
      # rpi-imager
      livecaptions

      ### Social         ###
      vesktop
      beeper
      signal-desktop

      ### Multimedia     ###
      spotify
      vlc
      youtube-music

      ### Gaming         ###
      # itch
      lutris
      prismlauncher
      # r2modman
      steam
      # winetricks
      # wineWowPackages.stable
      openrct2

      ### Graphical work ###
      blender
      inkscape
      krita
      gimp

      ### Development    ###
      # beekeeper-studio
      # gitkraken
      # godot_4
      # insomnia
      # lapce
      # ldtk
      # vscode
      # pulsar
      zed-editor

      ### Customization  ###
      # gradience
      # bibata-cursors
      # orchis-theme
      # tela-circle-icon-theme
      # zafiro-icons
    ];
  };
}
