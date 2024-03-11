{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zellij;
in {
  options.modules.zellij = {enable = mkEnableOption "zellij";};
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        theme = "everforest-dark";

        themes.everforest-dark = {
          bg = "#2d353b";
          fg = "#d3c6aa";

          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
          orange = "#e69875";
        };
      };
    };
  };
}
