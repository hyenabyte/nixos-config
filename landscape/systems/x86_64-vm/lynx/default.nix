{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  ${namespace} = {
    system.nix = enabled;
    suites.common = enabled;
    services.openssh = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
