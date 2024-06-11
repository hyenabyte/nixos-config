{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nix-snippets;
in {
  options.modules.nix-snippets = {enable = mkEnableOption "nix-snippets";};
  config = mkIf cfg.enable {
    programs.vscode.languageSnippets.nix = {
      "Nixos Config Module" = {
        prefix = "_module";
        body = [
          "{"
          "  pkgs,"
          "  lib,"
          "  config,"
          "  ..."
          "}:"
          "with lib; let"
          "  cfg = config.modules.$1;"
          "in {"
          "  options.modules.$1 = {enable = mkEnableOption \"$1\";};"
          "  config = mkIf cfg.enable {"
          "    $0"
          "  };"
          "}"
        ];
      };
      "Blank File" = {
        prefix = "_blank";
        body = [
          "{"
          "  pkgs,"
          "  lib,"
          "  config,"
          "  ..."
          "}:"
          "{"
          "  $0"
          "}"
        ];
      };
    };
  };
}
