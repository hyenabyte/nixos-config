{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.fonts;
in {
  options.${namespace}.system.fonts = {
    enable = mkEnableOption "fonts";
    fonts = mkOpt (listOf package) [] "Extra fonts to install.";
  };
  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };
    fonts = {
      packages = with pkgs;
        [
          roboto
          corefonts
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          noto-fonts-extra
          (nerdfonts.override {fonts = ["Agave" "Iosevka"];})
        ]
        ++ cfg.fonts;

      fontconfig = {
        hinting.autohint = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          sansSerif = ["Noto Sans"];
          serif = ["Noto Serif"];
          monospace = ["Agave Nerd Font Mono"];
        };
      };
    };
  };
}