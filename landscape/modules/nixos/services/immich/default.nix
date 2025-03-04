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
  options.${namespace}.services.immich = { enable = mkEnableOption "immich"; };
  config = mkIf cfg.enable {
    services.immich = {
      enable = true;

      mediaLocation = "/mnt/disk/Shares/Private/Immich";

      settings.server.externalDomain = "https://img.hyenabyte.dev";
    };
    services.caddy = {
      virtualHosts."img.hyenabyte.dev".extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };
  };
}
