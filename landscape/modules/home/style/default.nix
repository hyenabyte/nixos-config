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
    };
  };

  config = mkIf cfg.enable {
    stylix.enable = true;

    # https://tinted-theming.github.io/tinted-gallery/
    stylix.polarity = cfg.polarity;

    # TODO: change color scheme depending on polarity
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme.dark}.yaml";
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
  };
}
