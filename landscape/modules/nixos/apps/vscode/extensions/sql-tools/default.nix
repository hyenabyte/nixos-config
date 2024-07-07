{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.sql-tools;
in {
  options.modules.sql-tools = {enable = mkEnableOption "sql-tools";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        mtxr.sqltools
        mtxr.sqltools-driver-mysql
        mtxr.sqltools-driver-pg
        mtxr.sqltools-driver-sqlite
      ];
      userSettings = {
      };
    };
  };
}
