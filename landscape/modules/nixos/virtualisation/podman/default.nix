{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.virtualisation.podman;
in {
  options.${namespace}.virtualisation.podman = {enable = mkEnableOption "podman";};
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
