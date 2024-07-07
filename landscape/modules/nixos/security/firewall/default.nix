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
    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}
