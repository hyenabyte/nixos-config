{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.kitty;
in {
  options.${namespace}.apps.kitty = {enable = mkEnableOption "Enable Kitty";};
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      themeFile = "everforest_dark_medium";
      settings = {
        # Fonts
        font_family = "Agave Nerd Font Mono";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = "12.0";

        # Bell
        enable_audio_bell = "no";

        # Window
        window_border_width = "0.5pt";
        window_margin_width = "0";
        window_padding_width = "12";
      };
    };
  };
}
