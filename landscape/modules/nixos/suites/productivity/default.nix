{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.productivity;
in
{
  options.${namespace}.suites.productivity = with types; {
    enable =
      mkEnableOption "Enable Productivity Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    ${namespace} = {
      apps = { };
    };
  };
}
