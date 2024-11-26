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
        # PasswordAuthentication = false;
      };

      ports = [ 22 ];
    };

    # TODO get keys
    # ${namespace}.user.extraOptions.openssh.authorizedKeys.keys =
  };
}
