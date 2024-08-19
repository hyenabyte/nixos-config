{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.fail2ban;
in {
  options.${namespace}.security.fail2ban = {enable = mkEnableOption "Enable fail2ban";};
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
    };
  };
}
