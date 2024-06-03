{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.firewall;
in {
  options.firewall = {enable = mkEnableOption "firewall";};
  config = mkIf cfg.enable {
    networking.firewall.enable = true;
    networking.firewall.allowPing = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [8080 8443];
    networking.firewall.allowedUDPPorts = [8080 8443];
  };
}
