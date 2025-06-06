{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.alacritty;
in
{
  options.${namespace}.apps.alacritty = { enable = mkEnableOption "Enable Alacritty"; };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings =
        {
          window = {
            padding.x = 20;
            padding.y = 20;
            dynamic_padding = true;
          };

          font = {
            # normal.family = "Agave Nerd Font Mono";
            # size = 12;
          };

          cursor.style = {
            # "Block" | "Underline" | "Beam"
            # Default: "Block"
            shape = "Underline";

            # "Never" | "Off" | "On" | "Always"
            # Default: "Off"
            blinking = "Off";
          };
        };
    };
  };
}
