{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [../../modules/default.nix];
  config.modules = {
    # gui
    alacritty.enable = true;
    firefox.enable = true;
    nextcloud-client.enable = true;

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

    # system
    packages.enable = true;
  };
}
