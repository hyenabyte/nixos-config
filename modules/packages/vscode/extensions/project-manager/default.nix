{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.project-manager;
in {
  options.project-manager = {enable = mkEnableOption "project-manager";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        alefragnani.project-manager
      ];
      userSettings = {
        "projectManager.git.baseFolders" = [];
      };
    };
  };
}
