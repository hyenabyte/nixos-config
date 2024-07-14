{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.wireless;
in {
  options.${namespace}.hardware.wireless = with types; {
    enable = mkEnableOption "Enable wireless";
  };

  config = mkIf cfg.enable {
    networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };
}
