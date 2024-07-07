{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.development;
in {
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Enable Development Suite";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        vscode = enabled;
      };

      cli = {
        lazygit = enabled;
      };

      tools = {
        direnv = enabled;
      };
    };
  };
}
