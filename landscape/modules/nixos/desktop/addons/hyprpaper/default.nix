{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hyprpaper;
in
{
  options.${namespace}.desktop.addons.hyprpaper = with types; {
    enable = mkEnableOption "Hyprpaper";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.hyprpaper = {
      enable = true;
      settings = { };
    };
  };
}
