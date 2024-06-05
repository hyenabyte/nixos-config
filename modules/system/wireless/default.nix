{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wireless;
in {
  options.wireless = {enable = mkEnableOption "wireless";};
  config = mkIf cfg.enable {
    networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };
}
