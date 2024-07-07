{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.cups;
in {
  options.${namespace}.system.cups = {enable = mkEnableOption "cups";};
  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
