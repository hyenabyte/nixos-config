{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    # gui
    ./packages/alacritty
    ./packages/firefox
    ./packages/nextcloud-client
    ./packages/obs-studio

    # cli
    ./packages/bat
    ./packages/bottom
    ./packages/direnv
    ./packages/git
    ./packages/gpg
    ./packages/helix
    ./packages/lsd
    ./packages/starship
    ./packages/zellij
    ./packages/zoxide
    ./packages/zsh
  ];
}
