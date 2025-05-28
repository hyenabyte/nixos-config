{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.bemenu;
in
{
  options.${namespace}.desktop.addons.bemenu = with types; {
    enable = mkBoolOpt false "bemenu";
  };

  config = mkIf cfg.enable {
    ${namespace}.home = {
      programs.bemenu = {
        enable = true;

        settings = { };
      };
    };
  };
}
