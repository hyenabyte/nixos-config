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
