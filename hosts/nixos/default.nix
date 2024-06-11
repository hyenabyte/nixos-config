{
  inputs,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.max-jobs = "auto";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
}