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
  options.${namespace}.apps.steam = with types; {
    enable = mkEnableOption "steam";
    enableGamemode = mkOpt bool true "Enable gamemode";
    enableMangohud = mkOpt bool true "Enable mangohud";
    enableGamescope = mkOpt bool false "Enable Gamescope";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.protonup ];
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];

      # localNetworkGameTransfers.openFirewall = true;
      # remotePlay.openFirewall = true;

      protontricks.enable = true;
      gamescopeSession.enable = mkIf cfg.enableGamescope true;
    };

    programs.gamemode = mkIf cfg.enableGamemode {
      enable = true;
    };
    programs.gamescope = mkIf cfg.enableGamescope {
      enable = true;
    };

    ${namespace}.home.programs.mangohud = mkIf cfg.enableMangohud {
      enable = true;
    };
  };
}
