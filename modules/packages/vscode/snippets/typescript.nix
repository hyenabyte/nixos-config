{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.typescript-snippets;
in {
  options.modules.typescript-snippets = {enable = mkEnableOption "typescript-snippets";};
  config = mkIf cfg.enable {
    programs.vscode.languageSnippets.typescript = {
      "API Handler" = {
        prefix = "_api";
        body = [
          "import { NextApiRequest, NextApiResponse } from \"next\";"
          ""
          "export default async function handler(req: NextApiRequest, res: NextApiResponse) {"
          "    $0"
          "}"
        ];
        description = "Insert an API handler";
      };
      "Class" = {
        prefix = "_class";
        body = [
          "export default class $1 {"
          "    $0"
          "}"
        ];
        description = "Insert a class";
      };
      "Interface" = {
        prefix = "_interface";
        body = [
          "export type $1 = {"
          "    $0"
          "}"
        ];
        description = "Insert an interface";
      };
    };
  };
}
