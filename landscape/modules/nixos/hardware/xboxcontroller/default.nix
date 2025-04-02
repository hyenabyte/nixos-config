{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.xboxcontroller;
in
{
  options.${namespace}.hardware.xboxcontroller = { enable = mkEnableOption "xboxcontroller"; };
  config = mkIf cfg.enable {
    hardware.xpadneo.enable = true;
  };
}
