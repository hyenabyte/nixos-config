{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.rectangle;
in
{
  options.${namespace}.apps.rectangle = { enable = mkEnableOption "Rectangle"; };
  config = mkIf cfg.enable {
    environment.packages = with pkgs; [
      rectangle
    ];
  };
}
