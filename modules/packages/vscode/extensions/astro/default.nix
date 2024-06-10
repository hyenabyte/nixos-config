{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.astro;
in {
  options.astro = {enable = mkEnableOption "astro";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        astro-build.astro-vscode
      ];
      userSettings."[astro]" = {
        "editor.defaultFormatter" = "astro-build.astro-vscode";
      };
    };
  };
}
