{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.uptime-kuma;
in
{
  options.${namespace}.services.uptime-kuma = { enable = mkEnableOption "Uptime Kuma"; };
  config = mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;
    };
    services.caddy = {
      virtualHosts."uptime.hyenabyte.dev".extraConfig = ''
        reverse_proxy localhost:3001
      '';
    };
  };
}
