{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.grub;
in {
  options.modules.grub = {enable = mkEnableOption "grub";};
  config = mkIf cfg.enable {
    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;
  };
}
