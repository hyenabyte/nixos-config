{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.logseq;
in {
  options.${namespace}.apps.logseq = {enable = mkEnableOption "Enable Logseq";};
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.logseq
    ];

    # TODO: add logseq config
  };
}
