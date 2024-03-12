{
  inputs,
  pkgs,
  config,
  ...
}: {
  home.stateVersion = "23.11";
  imports = [
    # gui
    ./alacritty
    ./firefox
    ./nextcloud-client

    # cli
    ./bat
    ./bottom
    ./direnv
    ./git
    ./gpg
    ./helix
    ./lsd
    ./starship
    ./zellij
    ./zoxide
    ./zsh

    # system
    ./packages
  ];
}
