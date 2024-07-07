{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.touchpad;
in {
  options.${namespace}.hardware.touchpad = {enable = mkEnableOption "touchpad";};
  config = mkIf cfg.enable {
    services.xserver.libinput.enable = true;
  };
}
