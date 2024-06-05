{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.cups;
in {
  options.cups = {enable = mkEnableOption "cups";};
  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
