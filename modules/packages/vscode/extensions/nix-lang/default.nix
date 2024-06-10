{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nix-lang;
in {
  options.nix-lang = {enable = mkEnableOption "nix-lang";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        kamadorueda.alejandra
      ];
      userSettings = {
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
