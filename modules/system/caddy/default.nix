{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.caddy;
in {
  options.modules.caddy = {enable = mkEnableOption "caddy";};
  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;

      globalConfig = ''
        http_port 8080
        https_port 8443
      '';

      virtualHosts."www.hyenabyte.dev".extraConfig = ''
        redir https://hyenabyte.dev{uri} permanent
      '';

      virtualHosts."hyenabyte.dev".extraConfig = ''
        respond "Hello, World!" 200
      '';

      virtualHosts."jelly.hyenabyte.dev".extraConfig = ''
        reverse_proxy localhost:8096
      '';
    };
  };
}
