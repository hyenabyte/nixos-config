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
      multimedia = enabled;
      development = enabled;
      social = enabled;
      creative = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
