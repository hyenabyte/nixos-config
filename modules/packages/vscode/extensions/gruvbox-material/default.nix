{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gruvbox-material;
in {
  options.modules.gruvbox-material = {enable = mkEnableOption "gruvbox-material";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        sainnhe.gruvbox-material
      ];
      userSettings = {
        "gruvboxMaterial.darkContrast" = "soft";
        "gruvboxMaterial.colorfulSyntax" = true;
        "gruvboxMaterial.darkCursor" = "red";
        "gruvboxMaterial.darkWorkbench" = "flat";
        "workbench.preferredDarkColorTheme" = "Gruvbox Material Dark";
        "workbench.preferredLightColorTheme" = "Gruvbox Material Light";
        "workbench.colorTheme" = "Gruvbox Material Dark";
      };
    };
  };
}
