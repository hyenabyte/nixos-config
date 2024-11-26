{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.containers.caddy;
in
{
  options.${namespace}.containers.caddy = { enable = mkEnableOption "caddy"; };
  config = mkIf cfg.enable {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 8080 8443 ];
    networking.firewall.allowedUDPPorts = [ 8080 8443 ];

    virtualisation.oci-containers.containers = {
      caddy = {
        image = "caddy:latest";
        ports = [
          "8080:80"
          "8443:443"
        ];
      };
    };
  };
}
