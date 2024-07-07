{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.direnv;
in {
  options.${namespace}.tools.direnv = {enable = mkEnableOption "direnv";};
  config = mkIf cfg.enable {
    ${namespace}.home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
