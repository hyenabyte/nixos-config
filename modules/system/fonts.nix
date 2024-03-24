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
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        (nerdfonts.override {fonts = ["Agave" "Iosevka"];})
      ];

      fontconfig = {
        hinting.autohint = true;
        defaultFonts = {
          # emoji = [""];
          monospace = ["Agave Nerd Font Mono"];
        };
      };
    };
  };
}
