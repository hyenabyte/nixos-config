{ lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  ${namespace} = {
    services.openssh = enabled;

    suites = {
      common = enabled;
      desktop = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
