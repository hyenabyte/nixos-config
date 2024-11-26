{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.containers.whoami;
in
{
  options.${namespace}.containers.whoami = { enable = mkEnableOption "whoami"; };
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      whoami = {
        image = "jwilder/whoami";
        ports = [ "8000:8000" ];
      };
    };
  };
}
