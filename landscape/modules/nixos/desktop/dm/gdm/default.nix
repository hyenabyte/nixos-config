{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.dm.gdm;
in
{
  options.${namespace}.desktop.dm.gdm = with types; {
    enable = mkEnableOption "GDM";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    suspend = mkBoolOpt true "Whether or not to suspend the machine after inactivity.";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = cfg.wayland;
      autoSuspend = cfg.suspend;
    };
  };
}
