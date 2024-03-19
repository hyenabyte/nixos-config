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
    ../../modules/system/bluetooth.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/tailscale.nix
  ];

  nvidia.enable = true;
  locale-dk.enable = true;
  fonts.enable = true;
  plasma.enable = true;
  tailscale.enable = true;
  bluetooth.enable = true;
  pipewire.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
