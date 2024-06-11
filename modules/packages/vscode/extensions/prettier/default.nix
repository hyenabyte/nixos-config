{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.prettier;
in {
  options.modules.prettier = {enable = mkEnableOption "prettier";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        esbenp.prettier-vscode
      ];
      userSettings = {
        "prettier.singleQuote" = true;
        "prettier.tabWidth" = 4;
      };
    };
  };
}
