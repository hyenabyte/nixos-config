{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.color-highlight;
in {
  options.modules.color-highlight = {enable = mkEnableOption "color-highlight";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        naumovs.color-highlight
      ];
      userSettings = {
        "color-highlight.markerType" = "underline";
      };
    };
  };
}
