{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.budgie;
in {
  options.${namespace}.desktop.budgie = {enable = mkEnableOption "budgie";};
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.budgie.enable = true;
  };
}
