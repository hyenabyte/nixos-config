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
        corefonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
        (nerdfonts.override {fonts = ["Agave" "Iosevka"];})
      ];

      fontconfig = {
        hinting.autohint = true;
        defaultFonts = {
          # emoji = [""];
          sansSerif = ["Roboto" "Noto Sans"];
          serif = ["Noto Serif"];
          monospace = ["Agave Nerd Font Mono"];
        };
      };
    };
  };
}
