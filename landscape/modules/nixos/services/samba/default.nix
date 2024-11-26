{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.samba;
in
{
  options.${namespace}.services.samba = { enable = mkEnableOption "samba"; };
  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          security = "user";
          # "use sendfile" = "yes";
          # "max protocol" = "smb2";
          "hosts allow" = "192.168.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };

        "public" = {
          path = "/mnt/disk/Shares/Public";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "hyena";
          "force group" = "users";
        };

        "private" = {
          path = "/mnt/disk/Shares/Private";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "hyena";
          "force group" = "users";
        };
      };
    };

    services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
    services.samba-wsdd.openFirewall = true;
  };
}
