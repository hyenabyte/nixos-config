{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.markdown;
in {
  options.markdown = {enable = mkEnableOption "markdown";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        davidanson.vscode-markdownlint
      ];
      userSettings."[markdown]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
      };
    };
  };
}
