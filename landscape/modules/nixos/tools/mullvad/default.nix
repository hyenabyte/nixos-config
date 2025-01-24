{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.mullvad;
in
{
  options.${namespace}.tools.mullvad = with types; {
    enable = mkEnableOption "Mullvad VPN";
  };

  config = mkIf cfg.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
