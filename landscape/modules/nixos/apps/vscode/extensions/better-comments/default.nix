{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.better-comments;
in {
  options.modules.better-comments = {enable = mkEnableOption "better-comments";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        aaron-bond.better-comments
      ];
      userSettings = {
        "better-comments.tags" = [
          {
            "tag" = "!";
            "color" = "#FF2D00";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            "tag" = "?";
            "color" = "#3498DB";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            "tag" = "//";
            "color" = "#474747";
            "strikethrough" = true;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            "tag" = "todo";
            "color" = "#FF8C00";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            "tag" = "fixme";
            "color" = "#fc6fd6";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            "tag" = "*";
            "color" = "#98C379";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
        ];
      };
    };
  };
}
