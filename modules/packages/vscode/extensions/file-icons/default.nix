{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.file-icons;
in {
  options.file-icons = {enable = mkEnableOption "file-icons";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        file-icons.file-icons
      ];
      userSettings = {
        "workbench.iconTheme" = "file-icons";
      };
    };
  };
}
