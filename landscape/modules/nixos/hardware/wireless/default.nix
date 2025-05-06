{ options
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.wireless;
in
{
  options.${namespace}.hardware.wireless = with types; {
    enable = mkEnableOption "Enable wireless";
    enableIwd = mkOpt bool false "Enable iwd";
  };

  config = mkIf cfg.enable {
    networking = {
      wireless = {
        enable = mkUnless cfg.enableIwd true; # Enables wireless support via wpa_supplicant.
        userControlled.enable = true; # Fixes error on switch when trying to restart wpa_supplicant

        iwd = mkIf cfg.enableIwd {
          enable = true;
          settings = {
            Network = {
              EnableIPv6 = true;
              RoutePriorityOffset = 300;
            };
            Settings = {
              AutoConnect = true;
              Hidden = true;
              AlwaysRandomizeAddress = false;
            };
          };
        };
      };
      networkmanager.wifi.backend = mkIf cfg.enableIwd "iwd";
      interfaces = { };
    };
  };
}
