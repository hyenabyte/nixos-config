{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.rust;
in {
  options.rust = {enable = mkEnableOption "rust";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        # statiolake.vscode-rustfmt
        vadimcn.vscode-lldb
      ];
      userSettings = {
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
      };
    };
  };
}
