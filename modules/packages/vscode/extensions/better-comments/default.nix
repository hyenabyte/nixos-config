{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.better-comments;
in {
  options.better-comments = {enable = mkEnableOption "better-comments";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        aaron-bond.better-comments
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    };
  };
}
