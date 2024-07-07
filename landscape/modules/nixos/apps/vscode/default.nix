{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vscode;
in {
  imports = [
    ./snippets
    ./user-settings
    ./extensions
  ];
  options.${namespace}.apps.vscode = {enable = mkEnableOption "vscode";};
  config = mkIf cfg.enable {
    home.programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
