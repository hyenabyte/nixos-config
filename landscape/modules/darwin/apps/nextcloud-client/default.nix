{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.nextcloud-client;
in {
  options.${namespace}.apps.nextcloud-client = {
    enable = mkEnableOption "Enable nextcloud-client";
    startInBackground = mkBoolOpt false "Start Nextcloud Client in the background when powering on the system.";
  };
  config = mkIf cfg.enable {
    ${namespace}.home.services.nextcloud-client = {
      enable = true;
      startInBackground = cfg.startInBackground;
    };
  };
}
