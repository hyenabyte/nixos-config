{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.rust;
in {
  options.modules.rust = {enable = mkEnableOption "rust";};
  config = mkIf cfg.enable {
    programs.vscode = {
      extensions = with pkgs.vscode-marketplace; [
        rust-lang.rust-analyzer
        statiolake.vscode-rustfmt
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
