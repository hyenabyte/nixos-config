{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.vikunja;
in
{
  options.${namespace}.services.vikunja = with types; {
    enable = mkEnableOption "Vikunja";

    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    port = mkOpt int 5561 "The port";
    domain = mkOpt str "localhost" "The domain";
    scheme = mkOpt str "http" "http or https";
    enableUserRegistration = mkOpt bool false "Enable user registration";
  };
  config = mkIf cfg.enable {
    services.vikunja = {
      enable = true;
      port = cfg.port;
      frontendHostname = cfg.domain;
      frontendScheme = cfg.scheme;
      settings = {
        service = {
          publicurl = "${cfg.scheme}://${cfg.domain}";
          enableregistration = cfg.enableUserRegistration;
        };
        defaultsettings = {
          week_start = 1;
        };
      };
    };
    services.caddy =
      mkIf cfg.enableCaddyIntegration {
        virtualHosts.${cfg.domain}.extraConfig = ''
          reverse_proxy localhost:${builtins.toString cfg.port}
        '';
      };
  };
}
