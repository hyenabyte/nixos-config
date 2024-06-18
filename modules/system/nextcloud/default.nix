{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nextcloud;
in {
  options.modules.nextcloud = {enable = mkEnableOption "nextcloud";};
  config = mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      hostName = "https://cloud.hyenabyte.dev";
    };
  };
}
