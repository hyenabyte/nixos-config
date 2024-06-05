{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.touchpad;
in {
  options.touchpad = {enable = mkEnableOption "touchpad";};
  config = mkIf cfg.enable {
    services.xserver.libinput.enable = true;
  };
}
