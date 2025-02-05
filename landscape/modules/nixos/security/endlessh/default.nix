{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.endlessh;
in
{
  options.${namespace}.security.endlessh = { enable = mkEnableOption "endlessh"; };
  config = mkIf cfg.enable {
    services.endlessh = {
      enable = true;
      port = 2222;
      openFirewall = true;
    };
  };
}
