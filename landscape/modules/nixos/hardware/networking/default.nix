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
    # environment.persist.directories = [
    #   "/etc/NetworkManager"
    # ];
  };
}
