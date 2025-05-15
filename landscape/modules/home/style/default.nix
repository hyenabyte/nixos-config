{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.style;
in
{
  options.${namespace}.style = with types; {
    enable = mkEnableOption "Style";
  };

  config = mkIf cfg.enable {
    stylix.enable = true;

    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";
    stylix.image = "${pkgs."${namespace}".wallpapers}/share/wallpapers/eclipse.jpg";

    stylix.polarity = "light";
    stylix.fonts = {

      sansSerif = {
        package = pkgs.atkinson-hyperlegible;
        name = "Atkinson Hyperlegible";
      };
      serif = config.stylix.fonts.sansSerif;

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "Agave" ]; });
        name = "Agave Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    stylix.cursor = {
      package = pkgs.${namespace}.colloid-cursor-theme;
      name = "Colloid-cursors";
      size = 32;
    };

    stylix.iconTheme = {
      enable = true;
      package = pkgs.${namespace}.colloid-icon-theme;
      dark = "Colloid-Everforest-Dark";
      light = "Colloid-Everforest-Light";
    };
  };
}
