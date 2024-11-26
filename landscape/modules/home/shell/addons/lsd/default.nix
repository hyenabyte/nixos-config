{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.shell.addons.lsd;
in
{
  options.${namespace}.shell.addons.lsd = with types; {
    enable = mkEnableOption "lsd";
    enableAliases = mkBoolOpt false "Enable shell aliases";
  };

  config = mkIf cfg.enable {
    # lsd replaceses ls
    programs.lsd = {
      enable = true;
      enableAliases = cfg.enableAliases;
    };
  };
}
