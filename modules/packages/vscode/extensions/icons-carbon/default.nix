{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.icons-carbon;
in {
  options.modules.icons-carbon = {enable = mkEnableOption "icons-carbon";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        antfu.icons-carbon
      ];
      userSettings = {
        "workbench.productIconTheme" = "icons-carbon";
      };
    };
  };
}
