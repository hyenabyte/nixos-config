{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.wireless;
in {
  options.modules.wireless = {enable = mkEnableOption "wireless";};
  config = mkIf cfg.enable {
    networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };
}
