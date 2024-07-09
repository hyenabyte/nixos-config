{
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # Ayaneo Air 1S

  imports = [
    # System hardware configuration
    # ./hardware-configuration.nix
  ];

  ${namespace} = {
    suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
