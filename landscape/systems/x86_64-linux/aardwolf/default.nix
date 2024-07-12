{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # My Desktop PC

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.chromium
    pkgs.caffeine-ng
  ];

  ${namespace} = {
    suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      productivity = enabled;
      multimedia = enabled;
      development = enabled;
      social = enabled;
      creative = enabled;
    };

    apps = {
      # nextcloud-client = enabled;
      obs-studio = enabled;
    };

    cli = {
      zellij = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = enabled;
    };
  };

  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
