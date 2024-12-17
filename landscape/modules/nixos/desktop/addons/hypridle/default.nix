{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hypridle;
in
{
  options.${namespace}.desktop.addons.hypridle = with types; {
    enable = mkEnableOption "Hypridle";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.hypridle = {
      enable = true;
      settings = { };
    };
  };
}
