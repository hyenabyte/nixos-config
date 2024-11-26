{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.bottom;
in
{
  options.${namespace}.cli.bottom = { enable = mkEnableOption "bottom"; };
  config = mkIf cfg.enable {
    programs.bottom = {
      enable = true;
    };
  };
}
