{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.prettier;
in {
  options.prettier = {enable = mkEnableOption "prettier";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
      ];
      userSettings = {
        "prettier.singleQuote" = true;
        "prettier.tabWidth" = 4;
      };
    };
  };
}
