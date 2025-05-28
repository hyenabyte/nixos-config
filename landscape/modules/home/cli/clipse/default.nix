{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli.clipse;
in
{
  options.${namespace}.cli.clipse = with types; {
    enable = mkEnableOption "clipse";
  };

  config = mkIf cfg.enable {
    services.clipse = {
      enable = true;
    };
  };
}
