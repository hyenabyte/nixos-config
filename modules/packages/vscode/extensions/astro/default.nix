{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.astro;
in {
  options.modules.astro = {enable = mkEnableOption "astro";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        astro-build.astro-vscode
      ];
      userSettings."[astro]" = {
        "editor.defaultFormatter" = "astro-build.astro-vscode";
      };
    };
  };
}
