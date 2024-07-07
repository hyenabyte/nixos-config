{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.catppuccin;
in {
  options.modules.catppuccin = {enable = mkEnableOption "catppuccin";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        catppuccin.catppuccin-vsc
      ];
      userSettings = {
        "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
        "workbench.colorTheme" = "Catppuccin Mocha";
      };
    };
  };
}
