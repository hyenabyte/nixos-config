{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.budgie;
in {
  options.modules.budgie = {enable = mkEnableOption "budgie";};
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.budgie.enable = true;
  };
}
