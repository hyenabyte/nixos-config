{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.file-icons;
in {
  options.modules.file-icons = {enable = mkEnableOption "file-icons";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        file-icons.file-icons
      ];
      userSettings = {
        "workbench.iconTheme" = "file-icons";
      };
    };
  };
}
