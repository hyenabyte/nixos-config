{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.spacedrive;
in
{
  options.${namespace}.apps.spacedrive = { enable = mkEnableOption "Spacedrive"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spacedrive
    ];
  };
}
