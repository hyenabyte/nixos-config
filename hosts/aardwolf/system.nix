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
    ../../modules/system/tailscale.nix
  ];

  locale-dk.enable = true;
  tailscale.enable = true;
}
