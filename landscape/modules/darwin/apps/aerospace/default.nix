{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.aerospace;
in
{
  options.${namespace}.apps.aerospace = { enable = mkEnableOption "Aerospace"; };
  config = mkIf cfg.enable {
    enviroment.packages = with pkgs; [
      aerospace
    ];
  };
}
