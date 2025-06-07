{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hyprpolkitagent;
in
{
  options.${namespace}.desktop.addons.hyprpolkitagent = with types; {
    enable = mkEnableOption "hyprpolkitagent";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.hyprpolkitagent = {
      enable = true;
    };
  };
}
