{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.nextcloud;
in
{
  options.${namespace}.services.nextcloud = { enable = mkEnableOption "nextcloud"; };
  config = mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      hostName = "https://cloud.hyenabyte.dev";
    };
  };
}
