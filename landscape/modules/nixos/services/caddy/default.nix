{ lib
, config
, namespace
, ...
}:
with lib; let
  cfg = config.${namespace}.services.caddy;
in
{
  options.${namespace}.services.caddy = { enable = mkEnableOption "caddy"; };
  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 8080 8443 ];
    networking.firewall.allowedUDPPorts = [ 8080 8443 ];
    services.caddy = {
      enable = true;

      globalConfig = ''
        http_port 8080
        https_port 8443
      '';

      virtualHosts."www.hyenabyte.dev".extraConfig = ''
        redir https://hyenabyte.dev{uri} permanent
      '';

      virtualHosts."hyenabyte.dev".extraConfig = ''
        respond "Hello, World!" 200
      '';

    };
  };
}
