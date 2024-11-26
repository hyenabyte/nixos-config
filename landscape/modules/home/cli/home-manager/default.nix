{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.home-manager;
in
{
  options.${namespace}.cli.home-manager = { enable = mkEnableOption "Enable Home Manager CLI"; };
  config = mkIf cfg.enable {
    programs.home-manager.enable = true;
  };
}
