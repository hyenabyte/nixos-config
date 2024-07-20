{
  lib,
  namespace,
  ...
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
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "22.11";
}
