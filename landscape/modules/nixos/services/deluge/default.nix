{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.deluge;
in
{
  options.${namespace}.services.deluge = { enable = mkEnableOption "deluge"; };
  config = mkIf cfg.enable {
    services.deluge = {
      enable = true;
    };
  };
}
