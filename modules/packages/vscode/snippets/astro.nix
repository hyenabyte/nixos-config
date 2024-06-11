{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.astro-snippets;
in {
  options.modules.astro-snippets = {enable = mkEnableOption "astro-snippets";};
  config = mkIf cfg.enable {
    programs.vscode.languageSnippets.astro = {
      "Astro Component" = {
        prefix = "_comp";
        body = [
          "---"
          "interface Props {$1}"
          ""
          "const {$3} = Astro.props;"
          "---"
          ""
          "$0"
        ];
      };
    };
  };
}
