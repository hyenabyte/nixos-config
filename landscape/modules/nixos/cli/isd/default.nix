{ pkgs
, lib
, inputs
, system
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.isd;
in
{
  options.${namespace}.cli.isd = { enable = mkEnableOption "ISD"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.isd.packages."${system}".default
    ];
  };
}
