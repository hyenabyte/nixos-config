{pkgs, ...}: {
  imports = [../../modules/default.nix];
  config = {
    home.stateVersion = "23.11";

    # Modules
    modules = {
      # gui
      alacritty.enable = true;
      firefox.enable = true;
      nextcloud-client.enable = true;
      obs-studio.enable = true;

      # cli
      bat.enable = true;
      bottom.enable = true;
      direnv.enable = true;
      git.enable = true;
      gpg.enable = true;
      helix.enable = true;
      lsd.enable = true;
      starship.enable = true;
      zellij.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };

    # Packages
    home.packages = with pkgs; [
      ### Terminal       ###
      antidote
      croc
      lazygit
      neofetch
      xh
      xsel
      yazi

      ### Nix            ###
      nil
      alejandra

      ### Applications   ###
      bitwarden
      # gparted
      vesktop
      vivaldi

      ### Multimedia     ###
      spotify
      vlc

      ### Gaming         ###
      # itch
      lutris
      prismlauncher
      r2modman
      steam

      ### Graphical work ###
      blender
      inkscape
      krita

      ### Development    ###
      # beekeeper-studio
      # gitkraken
      godot_4
      # insomnia
      # lapce
      ldtk

      ### Customization  ###
      # gradience
      # bibata-cursors
      # orchis-theme
      # tela-circle-icon-theme
      # zafiro-icons
    ];
  };
}
