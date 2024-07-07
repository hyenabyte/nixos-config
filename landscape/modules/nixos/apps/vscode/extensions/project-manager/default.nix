{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.project-manager;
in {
  options.modules.project-manager = {enable = mkEnableOption "project-manager";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        alefragnani.project-manager
      ];
      userSettings = {
        "projectManager.git.baseFolders" = [];
      };
    };
  };
}
