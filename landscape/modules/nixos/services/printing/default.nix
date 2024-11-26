{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.printing;
in
{
  options.${namespace}.services.printing = { enable = mkEnableOption "Enable printing"; };
  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
