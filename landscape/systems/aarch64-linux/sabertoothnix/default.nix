{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # My MacBook NixOS partition

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  environment.systemPackages = [
    pkgs.chromium
    pkgs.croc
    pkgs.beekeeper-studio
    pkgs.bruno
  ];

  # Fix firefox craashing in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  ${namespace} = {
    suites = {
      common = enabled;
      desktop = enabled;
      #games = enabled;
      #multimedia = enabled;
      #development = enabled;
      #social = enabled;
      #creative = enabled;
    };

    cli = {
      lazygit = enabled;
    };

    hardware = {
      #bluetooth = enabled;
      #nvidia = enabled;
      #wireless = enabled;
      iwd = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.11";
}
