{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.nix-ld;
in
{
  options.${namespace}.tools.nix-ld = { enable = mkEnableOption "nix-ld"; };
  config = mkIf cfg.enable {
    programs.nix-ld.dev.enable = true;
  };
}
