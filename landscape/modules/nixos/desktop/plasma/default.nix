{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.plasma;
in
{
  options.${namespace}.desktop.plasma = { enable = mkEnableOption "plasma"; };
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    # Run sddm in wayland
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
