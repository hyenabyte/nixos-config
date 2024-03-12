{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nextcloud-client;
in {
  options.modules.nextcloud-client = {enable = mkEnableOption "nextcloud-client";};
  config = mkIf cfg.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
