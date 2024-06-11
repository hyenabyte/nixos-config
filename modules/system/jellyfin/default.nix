{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.jellyfin;
in {
  options.modules.jellyfin = {enable = mkEnableOption "jellyfin";};
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
