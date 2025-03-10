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

          # Deprecated in 25.05
          (nerdfonts.override { fonts = [ "Agave" "Iosevka" "FiraCode" ]; })

          # Ready in 25.05
          # nerd-fonts.agave
          # nerd-fonts.fira-code
          # nerd-fonts.iosevka
        ]
        ++ cfg.fonts;
    };
  };
}
