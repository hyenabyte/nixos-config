{ options
, pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkEnableOption "fonts";
    fonts = mkOpt (listOf package) [ ] "Extra fonts to install.";
  };
  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };
    fonts = {
      packages = with pkgs;
        [
          atkinson-hyperlegible
          atkinson-monolegible
          corefonts
          iosevka
          iosevka-comfy.comfy-wide
          montserrat
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-emoji
          noto-fonts-extra
          roboto

          # Deprecated in 25.05
          (nerdfonts.override { fonts = [ "Agave" "Iosevka" "FiraCode" ]; })

          # Ready in 25.05
          # nerd-fonts.agave
          # nerd-fonts.fira-code
          # nerd-fonts.iosevka
        ]
        ++ cfg.fonts;

      fontconfig = {
        hinting.autohint = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
          monospace = [ "Agave Nerd Font Mono" ];
        };
      };
    };
  };
}
