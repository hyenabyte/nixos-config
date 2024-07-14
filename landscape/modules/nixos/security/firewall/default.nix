{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.firewall;
in {
  options.${namespace}.security.firewall = {enable = mkEnableOption "firewall";};
  config = mkIf cfg.enable {
    # These settings are redundant as they both default to true
    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}
