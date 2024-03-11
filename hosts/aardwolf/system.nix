{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/configuration.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/locale-dk.nix
  ];

  locale-dk.enable = true;
}
