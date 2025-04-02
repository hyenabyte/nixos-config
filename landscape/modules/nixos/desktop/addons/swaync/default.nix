{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.swaync;
in
{
  options.${namespace}.desktop.addons.swaync = with types; {
    enable = mkEnableOption "Sway Notification Center";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.swaync = {
      enable = true;

      settings = { };
    };
  };
}
