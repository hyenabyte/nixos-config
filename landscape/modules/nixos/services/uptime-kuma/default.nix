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
  options.${namespace}.services.uptime-kuma = with types; {
    enable = mkEnableOption "Uptime Kuma";

    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    port = mkOpt int 5559 "The port";
    domain = mkOpt str "localhost" "The domain";
  };
  config = mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;
      settings = {
        PORT = builtins.toString cfg.port;
      };
    };
    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy localhost:${builtins.toString cfg.port}
      '';
    };
  };
}
