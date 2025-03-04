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
      caddy = enabled;
      jellyfin = enabled;
      samba = enabled;
      paperless-ngx = enabled;
      immich = enabled;
      uptime-kuma = enabled;
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
