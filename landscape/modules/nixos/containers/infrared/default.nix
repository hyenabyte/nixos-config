{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.containers.infrared;
in
{
  options.${namespace}.containers.infrared = {
    enable = mkEnableOption "infrared";

    configPath = mkOpt types.str "/home/hyena/Workspace/infrared" "Data folder";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      infrared = {
        image = "haveachin/infrared:latest";
        ports = [ "25565:25565/tcp" ];
        volumes = [
          "${cfg.configPath}/:/etc/infrared"
        ];
      };
    };
  };
}
