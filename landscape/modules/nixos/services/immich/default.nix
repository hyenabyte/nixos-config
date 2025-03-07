{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.immich;
in
{
  options.${namespace}.services.immich = with types; {
    enable = mkEnableOption "immich";
    mediaLocation = mkOpt str "" "The media location";

    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    port = mkOpt int 5558 "The port";
    domain = mkOpt str "localhost" "The domain";
  };
  config = mkIf cfg.enable {
    services.immich = {
      enable = true;

      # mediaLocation = "/mnt/disk/Shares/Private/Immich";
      mediaLocation = cfg.mediaLocation;

      settings.server.externalDomain = "https://${cfg.domain}";
      port = cfg.port;
    };
    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy localhost:${builtins.toString cfg.port}
      '';
    };
  };
}
