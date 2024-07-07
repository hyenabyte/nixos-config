{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.helix-keymap;
in {
  options.modules.helix-keymap = {enable = mkEnableOption "helix-keymap";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        silverquark.dancehelix
      ];

      userSettings = {
        "dance.modes" = {
          "input" = {
            "cursorStyle" = "underline-thin";
          };
          "insert" = {
            "cursorStyle" = "line";
          };
          "visual" = {
            "cursorStyle" = "block";
          };
          "normal" = {
            "cursorStyle" = "underline";
          };
        };
      };
    };
  };
}
