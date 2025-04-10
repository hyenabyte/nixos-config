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
  options.${namespace}.apps.steam = {
    enable = mkEnableOption "steam";
    enableGamemode = mkOpt types.bool true "Enable gamemode";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.mangohud pkgs.protonup ];
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];

      # localNetworkGameTransfers.openFirewall = true;
      # remotePlay.openFirewall = true;

      gamescopeSession.enable = true;
    };

    programs.gamemode = mkIf cfg.enableGamemode {
      enable = true;
    };
  };
}
