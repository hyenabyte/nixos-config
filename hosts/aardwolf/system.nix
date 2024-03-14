{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # System hardware configuration
    ./hardware-configuration.nix

    # System modules
    ../../modules/system/configuration.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/locale-dk.nix
    ../../modules/system/fonts.nix
    ../../modules/system/plasma.nix
    ../../modules/system/tailscale.nix
  ];

  nvidia.enable = true;
  locale-dk.enable = true;
  fonts.enable = true;
  plasma.enable = true;
  tailscale.enable = true;
}
