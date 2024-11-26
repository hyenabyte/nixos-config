{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.steam;
in
{
  options.${namespace}.apps.steam = { enable = mkEnableOption "steam"; };
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];

      # localNetworkGameTransfers.openFirewall = true;
      # remotePlay.openFirewall = true;
    };
  };
}
