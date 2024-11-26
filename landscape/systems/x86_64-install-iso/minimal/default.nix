{ pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  ${namespace} = {
    system.nix = enabled;
    suites.common = enabled;
  };
}
