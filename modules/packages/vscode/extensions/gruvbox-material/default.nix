{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.gruvbox-material;
in {
  options.gruvbox-material = {enable = mkEnableOption "gruvbox-material";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
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
