{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.karabiner-elements;
in
{
  options.${namespace}.apps.karabiner-elements = { enable = mkEnableOption "Karabiner Elements"; };
  config = mkIf cfg.enable {
    services.karabiner-elements = {
      enable = true;
    };
  };
}
