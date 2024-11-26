{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.shell.nushell;
in
{
  options.${namespace}.shell.nushell = { enable = mkEnableOption "Enable the Nushell"; };
  config = mkIf cfg.enable {
    programs = {
      # TODO
    };
  };
}
