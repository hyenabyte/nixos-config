{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.jellyfin;
in {
  options.${namespace}.services.jellyfin = {enable = mkEnableOption "jellyfin";};
  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
    };

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
  };
}
