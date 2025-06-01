{ lib
, namespace
, inputs
, ...
}:
with lib;
with lib.${namespace}; {
  # Possum
  # Thinkcentre Server

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  ${namespace} = {
    suites = {
      common = enabled;
      server = enabled;
    };

    services = {
      samba = enabled;

      tailscale = {
        enable = true;
        useRoutingFeatures = "server";
        isExitNode = true;
        subnetRouter = {
          enable = true;
          advertiseRoutes = [ "192.168.1.0/24" ];
        };
      };

      # Services
      caddy = enabled;

      jellyfin = {
        enable = true;
        enableCaddyIntegration = true;
        domain = "jelly.hyenabyte.dev";
      };

      immich = {
        enable = true;
        mediaLocation = "/mnt/disk/Shares/Private/Immich";

        enableCaddyIntegration = true;
        domain = "img.hyenabyte.dev";
      };

      uptime-kuma = {
        enable = true;
        enableCaddyIntegration = true;
        domain = "uptime.hyenabyte.dev";
      };

      paperless-ngx = {
        enable = true;
        enableCaddyIntegration = true;
        domain = "documents.hyenabyte.dev";
        port = 8000;
      };

      invidious = {
        enable = true;
      };

      redlib = enabled;

      homepage-dashboard = {
        enable = true;
        services = [
          {
            # Groups
            "Services" = [
              {
                # Services
                "Uptime Kuma" = {
                  description = "Services uptime monitor";
                  href = "https://uptime.hyenabyte.dev";
                  icon = "si-uptimekuma-#5CDD8B";
                };
              }
              {
                "Jellyfin" = {
                  description = "Media server";
                  href = "https://jelly.hyenabyte.dev";
                  icon = "si-jellyfin-#00A4DC";
                };
              }
              {
                "Immich" = {
                  description = "Image server";
                  href = "https://img.hyenabyte.dev";
                  icon = "si-immich-#4250AF";
                };

              }
              {
                "Paperless NGX" = {
                  description = "Document server";
                  href = "https://documents.hyenabyte.dev";
                  icon = "si-paperless-ngx-#17541F";
                };
              }
              {
                "Redlib" = {
                  description = "Reddit";
                  href = "http://possum:5560";
                  icon = "sh-redlib";
                };
              }
            ];
          }
        ];
        settings = {
          title = "Possum Homlab";
          layout = {
            "Services" = {
              style = "row";
              columns = 4;
            };
          };
        };
      };

      # hydra = enabled;
    };

    containers = {
      infrared = enabled;
      minecraft-servers.raspberry = {
        enable = true;

        port = "25567";
        properties = {
          initMemory = "1G";
          maxMemory = "6G";
        };
      };
    };

    security = {
      endlessh = enabled;
      agenix = {
        enable = true;
        secrets = {
          paperless-pw.file = inputs.secrets.outPath + "/paperless-pw.age";
        };
      };
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "22.11";
}
