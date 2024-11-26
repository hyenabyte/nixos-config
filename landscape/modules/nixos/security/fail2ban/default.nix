{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.fail2ban;
in
{
  options.${namespace}.security.fail2ban = { enable = mkEnableOption "Enable fail2ban"; };
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;

      maxretry = 5;
      bantime = "10m";

      # These IPs are always allowed
      ignoreIP = [ ];

      extraPackages = [ pkgs.ipset ];
      banaction = "iptables-ipset-proto6-allports";
    };
  };
}
