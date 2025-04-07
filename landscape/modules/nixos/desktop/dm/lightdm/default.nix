{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.dm.lightdm;
in
{
  options.${namespace}.desktop.dm.lightdm = with types; {
    enable = mkEnableOption "LightDM";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm = {
      enable = true;

      greeter = {
        enable = true;
      };
    };
  };
}
