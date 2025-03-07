{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.jellyfin;
in
{
  options.${namespace}.services.jellyfin = with types; {
    enable = mkEnableOption "jellyfin";

    enableCaddyIntegration = mkOpt bool false "Caddy integration";
    domain = mkOpt str "localhost" "The domain";
  };
  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
    };

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];

    services.caddy = mkIf cfg.enableCaddyIntegration {
      virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy localhost:8096
      '';
    };
  };
}
