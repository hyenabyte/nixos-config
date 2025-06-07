{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.udiskie;
in
{
  options.${namespace}.desktop.addons.udiskie = with types; {
    enable = mkEnableOption "udiskie";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.services.udiskie = {
      enable = true;
    };
  };
}
