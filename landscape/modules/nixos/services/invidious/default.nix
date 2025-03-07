{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.invidious;
in
{
  options.${namespace}.services.invidious = with types; {
    enable = mkEnableOption "invidious";
    port = mkOpt int 5556 "The port for invidious";
    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    domain = mkOpt str "localhost" "The domain for invidious";
  };
  config = mkIf cfg.enable {
    services.invidious = {
      enable = true;

      port = cfg.port;
      domain = cfg.domain;

      settings = {
        check_tables = true;

        db = {
          dbname = "invidious";
          host = "";
          port = 5432;
          user = "invidious";
          password = "";
        };

        registration_enabled = false;
      };
    };

    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts."${cfg.domain}".extraConfig = ''
        reverse_proxy localhost:${builtins.toString cfg.port}
      '';
    };
  };
}
