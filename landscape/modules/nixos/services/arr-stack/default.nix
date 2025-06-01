{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr-stack;
in
{
  options.${namespace}.services.arr-stack = { enable = mkEnableOption "arr-stack"; };
  config = mkIf cfg.enable {
    # Prowlarr
    services.prowlarr = {
      enable = true;
    };

    # Radarr
    services.radarr = {
      enable = true;
    };

    # Lidarr
    services.lidarr = {
      enable = true;
    };

    # Sonarr
    services.sonarr = {
      enable = true;
    };

    # Bazarr
    services.bazarr = {
      enable = true;
    };

    # Jellyseerr
    services.jellyseer = {
      enable = true;
    };
  };
}
