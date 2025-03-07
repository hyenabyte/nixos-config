{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.paperless-ngx;
in
{
  options.${namespace}.services.paperless-ngx = with types; {
    enable = mkEnableOption "paperless-ngx";
    port = mkOpt int 5557 "Port for paperless";
    domain = mkOpt str "localhost" "Domain for paperless";
    enableCaddyIntegration = mkOpt bool false "Caddy integration";
  };
  config = mkIf cfg.enable {
    services.paperless = {
      enable = true;

      port = cfg.port;

      dataDir = "/mnt/disk/paperless";

      consumptionDir = "/mnt/disk/Shares/Private/Paperless/consume";
      consumptionDirIsPublic = true;

      passwordFile = config.age.secrets.paperless-pw.path;

      # openMPThreadingWorkaround = true;

      settings = {
        PAPERLESS_OCR_USER_ARGS = {
          # Allow upload of signed documents
          invalidate_digital_signatures = true;
        };
      };
    };

    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy localhost:${builtins.toString cfg.port}
      '';
    };
  };
}
