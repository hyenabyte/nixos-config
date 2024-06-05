{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../../modules/packages
  #   inputs.nix-index-database.hmModules.nix-index
  #   inputs.agenix.homeManagerModules.default
  #   ../../users/notthebee/dots.nix
  #   ../../users/notthebee/age.nix
  #   ../../dots/tmux
  #   ../../dots/kitty
  ];

  home.stateVersion = "23.11";
  home.homeDirectory = lib.mkForce "/Users/hyena";

  programs.home-manager.enable = true;

  modules = {
    alacritty.enable = true;
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

  home.packages = with pkgs; [
    discord
    antidote
    croc
    lazygit
    neofetch
    xh
    xsel
    yazi
    nil
    alejandra
    deluge
    spotify
    prismlauncher
    blender
    inkscape
    gimp
    vscode
  ];
}
