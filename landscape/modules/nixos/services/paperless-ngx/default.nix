{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.paperless-ngx;
in {
  options.${namespace}.services.paperless-ngx = {enable = mkEnableOption "paperless-ngx";};
  config = mkIf cfg.enable {
    services.paperless = {
      enable = true;

      # address = "https://documents.hyenabyte.dev";
      port = 8000;

      dataDir = "/mnt/disk/paperless";

      consumptionDir = "/mnt/disk/Shares/Private/Paperless/consume";
      consumptionDirIsPublic = true;

      # mediaDir = "/mnt/disk/media";

      # user = "paperless";
      passwordFile = config.age.secrets.paperless-pw.path;

      # openMPThreadingWorkaround = true;

      settings = {};
    };
  };
}
