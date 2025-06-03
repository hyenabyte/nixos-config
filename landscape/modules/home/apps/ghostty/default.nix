{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.ghostty;
in
{
  options.${namespace}.apps.ghostty = { enable = mkEnableOption "Ghostty"; };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      enableZshIntegration = true;
      installBatSyntax = true;

      settings = {
        # initial-command = "zellij -l welcome";

        window-padding-x = 20;
        window-padding-y = 20;
        window-padding-balance = true;

        font-family = "Agave Nerd Font Mono";
        font-size = 12;
      };
    };
  };
}
