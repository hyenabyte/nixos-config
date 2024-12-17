{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.dunst;
in
{
  options.${namespace}.desktop.addons.dunst = with types; {
    enable = mkEnableOption "Dunst";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.dunst = {
      enable = true;

      # configFile = "";
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#eceff1";
          font = "Atkinson Hyperlegible";
        };

        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
    };
  };
}
