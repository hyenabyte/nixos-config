{ config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.nautilus;
in
{
  options.${namespace}.desktop.addons.nautilus = with types; {
    enable = mkEnableOption "Nautilus File Browser";
  };

  config = mkIf cfg.enable {
    services.gvfs = {
      enable = true;
      package = mkForce pkgs.gnome.gvfs;
    };

    environment.systemPackages = with pkgs;[
      nautilus
    ];
  };
}
