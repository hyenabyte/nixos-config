{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.discord;
in
{
  options.${namespace}.apps.discord = { enable = mkEnableOption "Enable Discord"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
