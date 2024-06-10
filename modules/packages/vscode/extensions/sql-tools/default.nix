{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.sql-tools;
in {
  options.sql-tools = {enable = mkEnableOption "sql-tools";};
  config = mkIf cfg.enable {
    programs.vscode = {
      # FIXME sqltools not in nixpkgs
      extensions = with pkgs.vscode-extensions; [
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
