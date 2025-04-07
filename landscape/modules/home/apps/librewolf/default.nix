{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.librewolf;
in
{
  options.${namespace}.apps.librewolf = with types; {
    enable = mkEnableOption "Enable Librewolf";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
