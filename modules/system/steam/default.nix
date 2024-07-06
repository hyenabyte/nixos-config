{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.steam;
in {
  options.modules.steam = {enable = mkEnableOption "steam";};
  config = mkIf cfg.enable {
    # Steam needs to be a system module since it is not part of home-manager
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];

      # localNetworkGameTransfers.openFirewall = true;
      # remotePlay.openFirewall = true;
    };
  };
}
