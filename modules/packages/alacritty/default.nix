{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.alacritty;
in {
  options.modules.alacritty = {enable = mkEnableOption "alacritty";};
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          padding.x = 20;
          padding.y = 20;
          dynamic_padding = true;
        };

        font = {
          normal.family = "Agave Nerd Font Mono";
          size = 12;
        };

        colors = {
          primary.background = "0x2d353b";
          primary.foreground = "0xd3c6aa";

          normal = {
            black = "0x475258";
            red = "0xe67e80";
            green = "0xa7c080";
            yellow = "0xdbbc7f";
            blue = "0x7fbbb3";
            magenta = "0xd699b6";
            cyan = "0x83c092";
            white = "0xd3c6aa";
          };
          bright = {
            black = "0x475258";
            red = "0xe67e80";
            green = "0xa7c080";
            yellow = "0xdbbc7f";
            blue = "0x7fbbb3";
            magenta = "0xd699b6";
            cyan = "0x83c092";
            white = "0xd3c6aa";
          };
        };
      };
    };
  };
}
