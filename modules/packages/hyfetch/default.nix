{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hyfetch;
in {
  options.modules.hyfetch = {enable = mkEnableOption "hyfetch";};
  config = mkIf cfg.enable {
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "agender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
        };
      };
    };
  };
}
