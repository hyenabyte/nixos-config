{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.nfs;
in
{
  options.${namespace}.services.nfs = { enable = mkEnableOption "nfs"; };
  config = mkIf cfg.enable {
    services.nfs.server = {
      enable = true;
    };
  };
}
