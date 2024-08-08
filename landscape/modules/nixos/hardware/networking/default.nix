{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.networking;
in {
  options.${namespace}.hardware.networking = with types; {
    enable = mkEnableOption "Enable networkmanager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;

    # Fix for deploy failing to restart network manager
    systemd.services.NetworkManager-wait-online.enable = mkForce false;

    # environment.persist.directories = [
    #   "/etc/NetworkManager"
    # ];
  };
}
