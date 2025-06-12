{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.openssh;
in
{
  options.${namespace}.services.openssh = { enable = mkEnableOption "Enable SSH server"; };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = [ "hyena" ];
      };

      ports = [ 22 ];
    };
  };
}
