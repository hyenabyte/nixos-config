{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hyprsunset;
in
{
  options.${namespace}.desktop.addons.hyprsunset = with types; {
    enable = mkEnableOption "hyprsunset";
  };

  config = mkIf cfg.enable {
    ${namespace}.home.services.hyprsunset = {
      enable = true;
    };
  };
}
