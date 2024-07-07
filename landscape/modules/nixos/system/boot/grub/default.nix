{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.boot.grub;
in {
  options.${namespace}.system.boot.grub = {
    enable = mkEnableOption "grub";
    device = mkOpt str "/dev/sda" "The disk grub is installed to.";
  };
  config = mkIf cfg.enable {
    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.device = cfg.device;
  };
}
