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
    ../../modules/system/locale-dk.nix
    ../../modules/system/tailscale.nix
    ../../modules/system/ssh.nix
    ../../modules/system/samba.nix
    ../../modules/system/firewall.nix
  ];

  locale-dk.enable = true;
  tailscale.enable = true;
  ssh.enable = true;
  samba.enable = true;
  firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
