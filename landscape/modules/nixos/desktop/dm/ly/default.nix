{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.dm.ly;
in
{
  options.${namespace}.desktop.dm.ly = with types; {
    enable = mkEnableOption "Ly";
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = { };
    };
  };
}
