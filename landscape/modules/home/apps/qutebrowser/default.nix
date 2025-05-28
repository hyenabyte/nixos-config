{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.qutebrowser;
in
{
  options.${namespace}.apps.qutebrowser = with types; {
    enable = mkEnableOption "Enable qutebrowser";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
