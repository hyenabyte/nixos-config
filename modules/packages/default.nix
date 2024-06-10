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
    ./vscode

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
