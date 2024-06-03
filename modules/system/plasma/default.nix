{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.plasma;
in {
  options.plasma = {enable = mkEnableOption "plasma";};
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.sddm.enable = true;
    # Run sddm in wayland
    # services.xserver.displayManager.sddm.wayland.enable = true;

    services.xserver.desktopManager.plasma6.enable = true;
  };
}
