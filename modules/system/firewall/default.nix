{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.firewall;
in {
  options.modules.firewall = {enable = mkEnableOption "firewall";};
  config = mkIf cfg.enable {
    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}
