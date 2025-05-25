{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.redlib;
in
{
  options.${namespace}.services.redlib = with types; {
    enable = mkEnableOption "redlib";

    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    port = mkOpt int 5560 "The port";
    domain = mkOpt str "localhost" "The domain";
  };
  config = mkIf cfg.enable {
    services.redlib = {
      enable = true;

      port = cfg.port;
    };
    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy localhost:${builtins.toString cfg.port}
      '';
    };
  };
}
