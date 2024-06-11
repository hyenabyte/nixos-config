{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.touchpad;
in {
  options.modules.touchpad = {enable = mkEnableOption "touchpad";};
  config = mkIf cfg.enable {
    services.xserver.libinput.enable = true;
  };
}
