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
    polarity = mkOpt str "dark" "Dark or Light mode";
    colorScheme = {
      light = mkOpt str "rose-pine-dawn" "Light mode color scheme";
      dark = mkOpt str "rose-pine" "Dark mode color scheme";
      isTintedGalleryTheme = mkOpt bool true "Get color scheme from tinted gallery";
    };
  };

  config =
    let
      colorSchemeName =
        if cfg.polarity == "dark"
        then cfg.colorScheme.dark
        else cfg.colorScheme.light;

      colorScheme =
        if cfg.colorScheme.isTintedGalleryTheme
        then "${pkgs.base16-schemes}/share/themes/${colorSchemeName}.yaml"
        else colorSchemeName;
    in
    mkIf cfg.enable {
      stylix.enable = true;

      stylix.polarity = cfg.polarity;

      # https://tinted-theming.github.io/tinted-gallery/
      stylix.base16Scheme = colorScheme;
      stylix.image = "${pkgs."${namespace}".wallpapers}/share/wallpapers/ocean.jpg";

      stylix.fonts = {
        sansSerif = {
          package = pkgs.atkinson-hyperlegible;
          name = "Atkinson Hyperlegible";
        };
        serif = config.stylix.fonts.sansSerif;

        monospace = {
          package = pkgs.nerd-fonts.agave;
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
        size = 24;
      };

      stylix.iconTheme = {
        enable = true;
        package = pkgs.${namespace}.colloid-icon-theme;
        dark = "Colloid-Everforest-Dark";
        light = "Colloid-Everforest-Light";
      };

      stylix.targets.bemenu = {
        enable = false;
        fontSize = 16;
      };
    };
}
