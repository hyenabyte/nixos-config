{ pkgs
, lib
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
    environment.systemPackages = with pkgs; [
      isd
    ];
  };
}
