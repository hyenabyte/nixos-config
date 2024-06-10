{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.catppuccin;
in {
  options.catppuccin = {enable = mkEnableOption "catppuccin";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
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
