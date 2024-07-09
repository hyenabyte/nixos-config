{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.hyfetch;
in {
  options.${namespace}.cli.hyfetch = {enable = mkEnableOption "hyfetch";};
  config = mkIf cfg.enable {
    ${namespace}.home.programs.hyfetch = {
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
