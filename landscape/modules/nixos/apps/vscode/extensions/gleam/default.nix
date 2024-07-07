{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gleam;
in {
  options.modules.gleam = {enable = mkEnableOption "gleam";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        gleam.gleam
      ];
      userSettings."[gleam]" = {
        "editor.defaultFormatter" = "gleam.gleam";
      };
    };
  };
}
