{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.bluetooth;
in {
  options.bluetoothe = {enable = mkEnableOption "bluetooth";};
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
}
