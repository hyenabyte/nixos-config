{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.everforest;
in {
  options.everforest = {enable = mkEnableOption "everforest";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        sainnhe.everforest
      ];
      userSettings = {
        "everforest.diagnosticTextBackgroundOpacity" = "12.5%";
        "everforest.darkCursor" = "red";
        "everforest.darkContrast" = "soft";
        "everforest.darkWorkbench" = "high-contrast";
        "workbench.preferredDarkColorTheme" = "Everforest Dark";
        "workbench.preferredLightColorTheme" = "Everforest Light";
        "workbench.colorTheme" = "Everforest Dark";
      };
    };
  };
}
