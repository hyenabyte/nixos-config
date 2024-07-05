{
  pkgs,
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
        environment = {
          # TODO: store these securely
          ADMIN_PASSWORD = "changeme";
          ADMIN_USERNAME = "superuser";
          AUTOSAVE_INTERVAL = "15";
          BIND_IP = "0.0.0.0";
          DEFAULT_PORT = "16261";
          GAME_VERSION = "public";
          GC_CONFIG = "ZGC";
          MAP_NAMES = "Muldraugh, KY";
          MAX_PLAYERS = "16";
          MAX_RAM = "4096m";
          MOD_NAMES = "";
          MOD_WORKSHOP_IDS = "";
          PAUSE_ON_EMPTY = "true";
          PUBLIC_SERVER = "true";
          RCON_PASSWORD = "changeme_rcon";
          RCON_PORT = "27015";
          SERVER_NAME = "ZomboidServer";
          SERVER_PASSWORD = "";
          STEAM_VAC = "true";
          UDP_PORT = "16262";
          USE_STEAM = "true";
          TZ = "UTC";
        };
      };
    };
  };
}
