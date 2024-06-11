{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./base-settings.nix
    ./git-settings.nix
    ./terminal-settings.nix
  ];
}
