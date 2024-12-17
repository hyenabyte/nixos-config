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
  cfg = config.${namespace}.tools.input-remapper;
in
{
  options.${namespace}.tools.input-remapper = with types; {
    enable = mkEnableOption "Input Remapper";
  };

  config = mkIf cfg.enable {
    services.input-remapper = {
      enable = true;
    };
  };
}
