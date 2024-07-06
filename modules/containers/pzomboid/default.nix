{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.pzomboid;
in {
  options.modules.pzomboid = {enable = mkEnableOption "pzomboid";};
  config = mkIf cfg.enable {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [27015];
    networking.firewall.allowedUDPPorts = [16261 16262];

    # Container
    virtualisation.oci-containers.containers = {
      pzomboid = {
        image = "renegademaster/zomboid-dedicated-server:latest";
        ports = [
          "16261:16261/udp"
          "16262:16262/udp"
          "27015:27015/tcp"
        ];
        volumes = [
          # TODO: figure out how to place these somewhere sane
          "/home/hyena/pzomboid/ZomboidDedicatedServer:/home/steam/ZomboidDedicatedServer"
          "/home/hyena/pzomboid/ZomboidConfig:/home/steam/Zomboid/"
        ];
        environmentFiles = [
          config.age.secrets.pzomboid.path
        ];
      };
    };
  };
}
