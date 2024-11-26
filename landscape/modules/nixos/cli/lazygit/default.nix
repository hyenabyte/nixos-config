{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.lazygit;
in
{
  options.${namespace}.cli.lazygit = { enable = mkEnableOption "lazygit"; };
  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
