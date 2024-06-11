{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cups;
in {
  options.modules.cups = {enable = mkEnableOption "cups";};
  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
