{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.prisma;
in {
  options.modules.prisma = {enable = mkEnableOption "prisma";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        prisma.prisma
      ];
      userSettings."[prisma]" = {
        "editor.defaultFormatter" = "Prisma.prisma";
      };
    };
  };
}
