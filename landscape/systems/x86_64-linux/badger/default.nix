{
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # Badger
  # Contabo VPS

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  ${namespace} = {
    suites = {
      common = enabled;
      server = enabled;
    };

    services = {
      # caddy = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
