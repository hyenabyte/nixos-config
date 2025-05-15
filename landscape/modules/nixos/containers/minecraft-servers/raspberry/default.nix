{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.containers.minecraft-servers.raspberry;
in
{
  options.${namespace}.containers.minecraft-servers.raspberry = with types; {
    enable = mkEnableOption "Raspberry Flavoured Minecraft Server";

    configPath = mkOpt str "/home/hyena/Workspace/minecraft/raspberry" "Data folder";
    port = mkOpt str "25565" "The port for the server to bind to";
    properties = {
      initMemory = mkOpt str "1G" "Initial amount of memory to allocate to server";
      maxMemory = mkOpt str "2G" "Maximum amount of memory the server is allowed to use";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      mc-raspberry = {
        image = "itzg/minecraft-server";
        ports = [ "${cfg.port}:25565/tcp" ];
        volumes = [
          "${cfg.configPath}/:/data"
        ];

        environment = {
          "PACKWIZ_URL" = "https://asphodel.cc/packwiz/Ports/Curse/Raspberry-Server/pack.toml";
          "TYPE" = "FORGE";
          "EULA" = "TRUE";
          "VERSION" = "1.19.2";
          "INIT_MEMORY" = cfg.properties.initMemory;
          "MAX_MEMORY" = cfg.properties.maxMemory;
        };
      };
    };
  };
}
