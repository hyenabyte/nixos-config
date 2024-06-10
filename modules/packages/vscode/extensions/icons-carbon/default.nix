{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.icons-carbon;
in {
  options.icons-carbon = {enable = mkEnableOption "icons-carbon";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        antfu.icons-carbon
      ];
      userSettings = {
        "workbench.productIconTheme" = "icons-carbon";
      };
    };
  };
}
