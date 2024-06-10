{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.color-highlight;
in {
  options.color-highlight = {enable = mkEnableOption "color-highlight";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        naumovs.color-highlight
      ];
      userSettings = {
        "color-highlight.markerType" = "underline";
      };
    };
  };
}
