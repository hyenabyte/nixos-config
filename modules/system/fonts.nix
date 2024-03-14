{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.fonts;
in {
  options.fonts = {enable = mkEnableOption "fonts";};
  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        roboto
        openmoji-color
        (nerdfonts.override {fonts = ["Agave" "Iosevka"];})
      ];

      fontconfig = {
        hinting.autohint = true;
        defaultFonts = {
          emoji = ["OpenMoji Color"];
        };
      };
    };
  };
}
