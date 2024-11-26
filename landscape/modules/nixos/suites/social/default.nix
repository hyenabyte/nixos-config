{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.social;
in
{
  options.${namespace}.suites.social = with types; {
    enable =
      mkEnableOption "Enable Social Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
      beeper
      signal-desktop
      element
    ];

    ${namespace} = {
      apps = { };
    };
  };
}
