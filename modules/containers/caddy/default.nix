{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.caddy;
in {
  options.modules.caddy = {enable = mkEnableOption "caddy";};
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      caddy = {
        image = "caddy:latest";
        ports = [
          "8080:80"
          "8443:443"
        ];
      };
    };
  };
}
