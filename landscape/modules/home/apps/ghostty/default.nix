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

        # theme = "muteoki-dark";

        window-padding-x = 20;
        window-padding-y = 20;
        window-padding-balance = true;

        font-family = "Agave Nerd Font Mono";
        font-size = 12;


      };

      themes = {
        muteoki-dark = {

          background = "09090a";
          cursor-color = "d16469";
          foreground = "ebe0bc";
          cursor-style = "underline";
          cursor-style-blink = false;

          palette = [
            "0=#09090a"
            "1=#97484f"
            "2=#73794f"
            "3=#a17a2c"
            "4=#4c7288"
            "5=#a16a8d"
            "6=#407467"
            "7=#bdb193"
            # "8=#1d1d1c"
            "8=#4a4744"
            "9=#d16469"
            "10=#a6ae5a"
            "11=#dbb560"
            "12=#77afca"
            "13=#c193b0"
            "14=#72afa0"
            "15=#ebe0bc"
          ];
        };
      };
    };
  };
}
