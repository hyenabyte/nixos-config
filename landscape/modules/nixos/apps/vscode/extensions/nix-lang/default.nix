{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nix-lang;
in {
  options.modules.nix-lang = {enable = mkEnableOption "nix-lang";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        bbenoist.nix
        jnoortheen.nix-ide
        kamadorueda.alejandra
      ];
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
        "[nix]" = {
          "editor.insertSpaces" = true;
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
      };
    };
  };
}
