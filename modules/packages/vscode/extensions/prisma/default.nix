{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.prisma;
in {
  options.prisma = {enable = mkEnableOption "prisma";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        prisma.prisma
      ];
      userSettings."[prisma]" = {
        "editor.defaultFormatter" = "Prisma.prisma";
      };
    };
  };
}
