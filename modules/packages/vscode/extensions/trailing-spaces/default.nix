{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.trailing-spaces;
in {
  options.trailing-spaces = {enable = mkEnableOption "trailing-spaces";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        shardulm94.trailing-spaces
      ];
      userSettings = {
        "trailing-spaces.backgroundColor" = "rgba(50,48,47,0)";
        "trailing-spaces.borderColor" = "rgba(88,79,73,1)";
        "trailing-spaces.trimOnSave" = true;
      };
    };
  };
}
