{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.homepage-dashboard;
in
{
  options.${namespace}.services.homepage-dashboard = with types; {
    enable = mkEnableOption "homepage-dashboard";
    port = mkOpt types.int 8082 "The port the service should listen on";
    services = mkOpt (listOf attrs) [ ] "The services to show";
    settings = mkOpt attrs { } "Settings to pass to homepage";
  };
  config = mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = "localhost:${builtins.toString cfg.port},127.0.0.1:${builtins.toString cfg.port},possum:${builtins.toString cfg.port}";
      listenPort = cfg.port;

      settings = {
        title = "Homepage";
        description = "My homelab services";
        background = {
          image = "https://raw.githubusercontent.com/hyenabyte/nixos-config/refs/heads/main/landscape/packages/wallpapers/assets/clouds.jpg";
          blur = "2xl";
          color = "teal";
          headerStyle = "clean";
        };
      } // cfg.settings;

      services = cfg.services;
    };
  };
}
