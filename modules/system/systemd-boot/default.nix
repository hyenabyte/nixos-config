{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.systemd-boot;
in {
  options.modules.systemd-boot = {enable = mkEnableOption "systemd-boot";};
  config = mkIf cfg.enable {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
