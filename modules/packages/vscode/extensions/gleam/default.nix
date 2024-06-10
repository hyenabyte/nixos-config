{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.gleam;
in {
  options.gleam = {enable = mkEnableOption "gleam";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        gleam.gleam
      ];
      userSettings."[gleam]" = {
        "editor.defaultFormatter" = "gleam.gleam";
      };
    };
  };
}
