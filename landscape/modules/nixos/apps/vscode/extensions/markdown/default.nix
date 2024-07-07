{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.markdown;
in {
  options.modules.markdown = {enable = mkEnableOption "markdown";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        davidanson.vscode-markdownlint
      ];
      userSettings."[markdown]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
      };
    };
  };
}
