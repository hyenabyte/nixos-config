{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.whoami;
in {
  options.modules.whoami = {enable = mkEnableOption "whoami";};
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      whoami = {
        image = "jwilder/whoami";
        ports = ["8000:8000"];
      };
    };
  };
}
