{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.bluetooth;
in {
  options.${namespace}.hardware.bluetooth = {enable = mkEnableOption "bluetooth";};
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
}
