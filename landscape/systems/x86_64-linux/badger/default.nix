{ lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # Badger
  # Contabo VPS

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
      # caddy = enabled;
    };

    containers = {
      pzomboid = {
        enable = true;
        serverName = "yenas_pz_server";
      };
    };

    system.boot = {
      efi.enable = mkForce false;
      grub = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
