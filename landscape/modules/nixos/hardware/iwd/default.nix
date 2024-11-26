{ options
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.iwd;
in
{
  options.${namespace}.hardware.iwd = with types; {
    enable = mkEnableOption "Enable wireless (iwd)";
  };

  config = mkIf cfg.enable {
    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };
}
