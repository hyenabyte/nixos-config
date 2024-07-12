{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.games;
in {
  options.${namespace}.suites.games = with types; {
    enable =
      mkEnableOption "Enable Games Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # itch
      lutris
      prismlauncher
      # r2modman
      winetricks
      wineWowPackages.stable
      wine
      # openrct2
    ];

    ${namespace} = {
      apps = {
        steam = enabled;
      };
    };
  };
}
