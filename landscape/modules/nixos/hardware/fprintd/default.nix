{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.fprintd;
in
{
  options.${namespace}.hardware.fprintd = { enable = mkEnableOption "fingerprint"; };
  config = mkIf cfg.enable {
    services.fprintd = {
      enable = true;
    };
  };
}
