{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./base-settings.nix
  ];

  base-settings.enable = true;
}
