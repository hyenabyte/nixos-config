{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    # gui
    ./alacritty
    ./firefox
    ./nextcloud-client
    ./obs-studio

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
  ];
}
