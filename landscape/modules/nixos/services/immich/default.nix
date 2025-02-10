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
    };
  };
}
