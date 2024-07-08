{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # Virtual Machine Testing Platform

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  ${namespace} = {
    system.nix = enabled;
    suites.common = enabled;
    services.ssh = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
